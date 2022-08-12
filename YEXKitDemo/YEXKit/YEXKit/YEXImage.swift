/*******************************************************************************
Copyright (K), 2022 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/MemoryKing
********************************************************************************/

import Foundation
import UIKit
import Photos

// MARK: - 初始化构建器
public extension UIImage {
    ///根据颜色生成图片
    convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            self.init()
            return
        }
        UIGraphicsEndImageContext()
        guard let aCgImage = image.cgImage else {
            self.init()
            return
        }
        self.init(cgImage: aCgImage)
    }
    
    /// 根据view 生成image
    convenience init?(view: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        view.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let cgImage = image?.cgImage else {
            return nil
        }
        self.init(cgImage: cgImage)
    }
}

//MARK: --- 渐变
public extension UIImage {
    /// 渐变色方向
    enum YEXDirection {
        ///垂直
        case vertical
        ///水平
        case level
        ///左上到右下
        case leftTop
        ///左下到右上
        case leftBottom
    }
    
    ///线性渐变
    convenience init?(gradient size: CGSize,
                      YEXDirection: YEXDirection,
                      locations: Array<CGFloat> = [0.0,1.0] ,
                      colors: [UIColor]) {
        UIGraphicsBeginImageContext(size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        var cgColors = [CGColor]()
        colors.forEach { (colo) in
            cgColors.append(colo.cgColor)
        }
        let gradient = CGGradient.init(colorsSpace: colorSpace, colors: cgColors as CFArray, locations: locations)!
        
        var start = CGPoint()
        var end = CGPoint()
        switch YEXDirection {
            case .vertical:
                start = CGPoint.init(x: 0, y: 0)
                end = CGPoint.init(x: 0, y: size.height)
                break
            case .level:
                start = CGPoint.init(x: 0, y: 0)
                end = CGPoint.init(x: size.width, y: 0)
                break
            case .leftTop:
                start = CGPoint.init(x: 0, y: 0)
                end = CGPoint.init(x: size.width, y: size.height)
                break
            case .leftBottom:
                start = CGPoint.init(x: size.width, y: 0)
                end = CGPoint.init(x: 0, y: size.height)
                break
        }
        
        context.drawLinearGradient(gradient, start: start, end: end, options: .drawsBeforeStartLocation)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        UIGraphicsEndImageContext()
        guard let cgImage = image.cgImage else {
            return nil
        }
        self.init(cgImage: cgImage)
    }
    
    ///放射性渐变
    convenience init?(RadialGradients size: CGSize,
                      locations: Array<CGFloat> = [0.0,1.0],
                      colors: [UIColor]) {
        
        UIGraphicsBeginImageContext(size)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        var cgColors = [CGColor]()
        colors.forEach { (colo) in
            cgColors.append(colo.cgColor)
        }
        let gradient = CGGradient.init(colorsSpace: colorSpace, colors: cgColors as CFArray, locations: locations)!
        let center = CGPoint(x: size.width / 2, y: size.height / 2)
        //外圆半径
        let endRadius = min(size.width, size.height) / 2
        //内圆半径
        let startRadius = endRadius / 3
        //绘制渐变
        context.drawRadialGradient(gradient,
                                   startCenter: center, startRadius: startRadius,
                                   endCenter: center, endRadius: endRadius,
                                   options: .drawsBeforeStartLocation)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        UIGraphicsEndImageContext()
        guard let cgImage = image.cgImage else {
            return nil
        }
        self.init(cgImage: cgImage)
    }
    
}

//MARK: --- 图片处理
public extension UIImage {
    ///改变画质
    func yex_quality(_ quality: CGFloat = 1) -> UIImage? {
        guard let imageData = self.jpegData(compressionQuality: quality) else { return nil }
        return UIImage.init(data: imageData)
    }
    
    /// 截取指定Image的rect
    func yex_croping(_ rect: CGRect) -> UIImage {
        guard rect.size.height < self.size.height && rect.size.height < self.size.height else { return self }
        guard let image: CGImage = self.cgImage?.cropping(to: rect) else { return self }
        return UIImage(cgImage: image)
    }
    
    /// 旋转指定角度
    func yex_rotate(_ radians: Float) -> UIImage {
        let rotatedViewBox: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        let transformation: CGAffineTransform = CGAffineTransform(rotationAngle: CGFloat(radians))
        rotatedViewBox.transform = transformation
        let rotatedSize: CGSize = CGSize(width: Int(rotatedViewBox.frame.size.width), height: Int(rotatedViewBox.frame.size.height))
        UIGraphicsBeginImageContextWithOptions(rotatedSize, false, 0)
        guard let context: CGContext = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return self
        }
        context.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
        context.rotate(by: CGFloat(radians))
        context.scaleBy(x: 1.0, y: -1.0)
        context.draw(self.cgImage!, in: CGRect(x: -self.size.width / 2, y: -self.size.height / 2, width: self.size.width, height: self.size.height))
        guard let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return self
        }
        UIGraphicsEndImageContext()
        return newImage
    }
    
    ///图片压缩
    func yex_reset(_ maxSizeKB : CGFloat,_ maxWidth : CGFloat? = nil) -> UIImage? {
        let maxSize = maxSizeKB
        let maxImageSize = maxWidth ?? self.size.width
        //先调整分辨率
        var newSize = CGSize.init(width: self.size.width, height: self.size.height)
        let tempHeight = newSize.height / maxImageSize
        let tempWidth = newSize.width / maxImageSize
        if (tempWidth > 1.0 && tempWidth > tempHeight) {
            newSize = CGSize.init(width: self.size.width / tempWidth, height: self.size.height / tempWidth)
        }
        else if (tempHeight > 1.0 && tempWidth < tempHeight) {
            newSize = CGSize.init(width: self.size.width / tempHeight, height: self.size.height / tempHeight)
        }
        UIGraphicsBeginImageContext(newSize)
        self.draw(in: CGRect.init(x: 0, y: 0, width: newSize.width, height: newSize.height))
        
        if let newImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            if let imageData = newImage.jpegData(compressionQuality: 1.0) {
                var sizeOriginKB : CGFloat = CGFloat((imageData.count)) / 1024.0
                //调整大小
                var resizeRate = 0.9
                while (sizeOriginKB > maxSize && resizeRate > 0.1) {
                    if let data = newImage.jpegData(compressionQuality: CGFloat(resizeRate)) {
                        sizeOriginKB = CGFloat((data.count)) / 1024.0
                        resizeRate -= 0.1
                        return UIImage.init(data: data)
                    }
                }
            }
        }
        return nil
    }
    
    ///将图片绘制成制定大小
    func yex_scale(_ w: CGFloat,_ h: CGFloat) -> UIImage? {
        let newSize = CGSize(width: w, height: h)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// 重设图片大小
    func yex_resetSizeImage(_ reSize:CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale)
        self.draw(in: CGRect.init(x: 0, y: 0, width: reSize.width, height: reSize.height))
        guard let reSizeImage = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        
        UIGraphicsEndImageContext()
        return reSizeImage
    }
    
    /// 等比例缩放
    func yex_scaleImage(_ scaleSize:CGFloat) -> UIImage? {
        let reSize = CGSize(width: self.size.width * scaleSize, height: self.size.height * scaleSize)
        
        return yex_resetSizeImage(reSize)
    }
    
    ///点九拉伸  Stretch 拉伸模式   Tile 平铺模式
    func yex_resizableImage(insets: UIEdgeInsets,resizingMode: UIImage.ResizingMode) -> UIImage {
        return self.resizableImage(withCapInsets: insets, resizingMode: resizingMode)
    }
    
    /// 图片的模糊效果（高斯模糊滤镜）
    /// - Parameter fuzzyValue: 设置模糊半径值（越大越模糊）
    /// - Returns: 返回模糊后的图片
    func yex_gaussianBlurImage(fuzzyValue: CGFloat = 20) -> UIImage? {
        // 生成的高斯模糊滤镜图片
        return blurredPicture(fuzzyValue: fuzzyValue, filterName: "CIGaussianBlur")
    }
    
    ///像素化后的图片
    /// - Parameter fuzzyValue: 设置模糊半径值（越大越模糊）
    /// - Returns: 返回像素化后的图片
    func yex_pixellateImage(fuzzyValue: CGFloat = 20) -> UIImage? {
        // 生成的高斯模糊滤镜图片
        return blurredPicture(fuzzyValue: fuzzyValue, filterName: "CIPixellate")
    }
    
    ///带有圆角和边框的新图像。
    func yex_roundCorners(cornerRadius: CGFloat, border: CGFloat, color: UIColor) -> UIImage? {
        return yex_roundCorners(cornerRadius)?.yex_border(border: border, color: color)
    }
    
    ///带圆角的图片
    func yex_roundCorners(_ cornerRadius: CGFloat) -> UIImage? {
        let imageWithAlpha = applyAlpha()
        if imageWithAlpha == nil {
            return nil
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let width = imageWithAlpha?.cgImage?.width
        let height = imageWithAlpha?.cgImage?.height
        let bits = imageWithAlpha?.cgImage?.bitsPerComponent
        let colorSpace = imageWithAlpha?.cgImage?.colorSpace
        let bitmapInfo = imageWithAlpha?.cgImage?.bitmapInfo
        let context = CGContext(data: nil, width: width!, height: height!, bitsPerComponent: bits!, bytesPerRow: 0, space: colorSpace!, bitmapInfo: (bitmapInfo?.rawValue)!)
        let rect = CGRect(x: 0, y: 0, width: CGFloat(width!)*scale, height: CGFloat(height!)*scale)
        
        context?.beginPath()
        if (cornerRadius == 0) {
            context?.addRect(rect)
        } else {
            context?.saveGState()
            context?.translateBy(x: rect.minX, y: rect.minY)
            context?.scaleBy(x: cornerRadius, y: cornerRadius)
            let fw = rect.size.width / cornerRadius
            let fh = rect.size.height / cornerRadius
            context?.move(to: CGPoint(x: fw, y: fh/2))
            context?.addArc(tangent1End: CGPoint(x: fw, y: fh), tangent2End: CGPoint(x: fw/2, y: fh), radius: 1)
            context?.addArc(tangent1End: CGPoint(x: 0, y: fh), tangent2End: CGPoint(x: 0, y: fh/2), radius: 1)
            context?.addArc(tangent1End: CGPoint(x: 0, y: 0), tangent2End: CGPoint(x: fw/2, y: 0), radius: 1)
            context?.addArc(tangent1End: CGPoint(x: fw, y: 0), tangent2End: CGPoint(x: fw, y: fh/2), radius: 1)
            context?.restoreGState()
        }
        context?.closePath()
        context?.clip()
        
        context?.draw(imageWithAlpha!.cgImage!, in: rect)
        let image = UIImage(cgImage: (context?.makeImage()!)!, scale:scale, orientation: .up)
        UIGraphicsEndImageContext()
        return image
    }
    ///带有边框的图
    func yex_border(border: CGFloat, color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let width = self.cgImage?.width
        let height = self.cgImage?.height
        let bits = self.cgImage?.bitsPerComponent
        let colorSpace = self.cgImage?.colorSpace
        let bitmapInfo = self.cgImage?.bitmapInfo
        let context = CGContext(data: nil, width: width!, height: height!, bitsPerComponent: bits!, bytesPerRow: 0, space: colorSpace!, bitmapInfo: (bitmapInfo?.rawValue)!)
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        context?.setStrokeColor(red: red, green: green, blue: blue, alpha: alpha)
        context?.setLineWidth(border)
        
        let rect = CGRect(x: 0, y: 0, width: size.width*scale, height: size.height*scale)
        let inset = rect.insetBy(dx: border*scale, dy: border*scale)
        
        context?.strokeEllipse(in: inset)
        context?.draw(self.cgImage!, in: inset)
        
        let image = UIImage(cgImage: (context?.makeImage()!)!)
        UIGraphicsEndImageContext()
        
        return image
    }
    
    
    // MARK: Alpha
    /**
     Returns true if the image has an alpha layer.
     */
    private var hasAlpha: Bool {
        let alpha: CGImageAlphaInfo = self.cgImage!.alphaInfo
        switch alpha {
            case .first, .last, .premultipliedFirst, .premultipliedLast:
                return true
            default:
                return false
        }
    }
    /**
     返回给定图像的副本，如果还没有alpha通道，则添加一个alpha通道。
     */
    private func applyAlpha() -> UIImage? {
        if hasAlpha {
            return self
        }
        
        let imageRef = self.cgImage;
        let width = imageRef?.width;
        let height = imageRef?.height;
        let colorSpace = imageRef?.colorSpace
        
        // The bitsPerComponent and bitmapInfo values are hard-coded to prevent an "unsupported parameter combination" error
        let bitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo().rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue)
        let offscreenContext = CGContext(data: nil, width: width!, height: height!, bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace!, bitmapInfo: bitmapInfo.rawValue)
        
        // Draw the image into the context and retrieve the new image, which will now have an alpha layer
        let rect: CGRect = CGRect(x: 0, y: 0, width: CGFloat(width!), height: CGFloat(height!))
        offscreenContext?.draw(imageRef!, in: rect)
        let imageWithAlpha = UIImage(cgImage: (offscreenContext?.makeImage()!)!)
        return imageWithAlpha
    }
    
    /// 图片模糊
    /// - Parameters:
    ///   - fuzzyValue: 设置模糊半径值（越大越模糊）
    ///   - filterName: 模糊类型
    /// - Returns: 返回模糊后的图片
    private func blurredPicture(fuzzyValue: CGFloat, filterName: String) -> UIImage? {
        guard let ciImage = CIImage(image: self) else { return nil }
        // 创建高斯模糊滤镜类
        guard let blurFilter = CIFilter(name: filterName) else { return nil }
        // 设置图片
        blurFilter.setValue(ciImage, forKey: kCIInputImageKey)
        // 设置模糊半径值（越大越模糊）
        blurFilter.setValue(fuzzyValue, forKey: filterName == "CIPixellate" ? kCIInputScaleKey : kCIInputRadiusKey)
        // 从滤镜中 取出图片
        guard let outputImage = blurFilter.outputImage else { return nil }
        // 创建上下文
        let context = CIContext(options: nil)
        // 根据滤镜中的图片 创建CGImage
        guard let cgImage = context.createCGImage(outputImage, from: ciImage.extent) else { return nil }
        // 生成的模糊图片
        return UIImage(cgImage: cgImage)
    }
    
}

// MARK: - 保存到相册
public extension UIImage {
    /// 保存到相册
    func yex_savedPhotosAlbum(completion: @escaping ((Bool, Error?) -> Void))  {
        PHPhotoLibrary.shared().performChanges {
            PHAssetChangeRequest.creationRequestForAsset(from: self)
        } completionHandler: { (isSuccess: Bool, error: Error?) in
            completion(isSuccess, error)
        }
    }
}

//MARK: - 图片转换
public extension UIImage {
    /// image --> base64
    func yex_toBase64 (_ quality: CGFloat = 1,_ options: Data.Base64EncodingOptions = []) -> String {
        // 将图片转化成Data
        let imageData = self.jpegData(compressionQuality: quality)
        // 将Data转化成 base64的字符串
        let imageBase64String = imageData?.base64EncodedString(options: options) ?? ""
        return imageBase64String
    }
    
    /// image --> color
    func yex_toColor() -> UIColor? {
        return UIColor.init(patternImage: self)
    }
}

// MARK: - 图片旋转
public extension UIImage {
    /// 图片旋转 (角度)
    /// - Parameter degree: 角度 0 -- 360
    /// - Returns: 旋转后的图片
    func yex_rotated(degree: CGFloat) -> UIImage? {
        let radians = Double(degree) / 180 * Double.pi
        return yex_rotated(radians: CGFloat(radians))
    }
    
    /// 图片旋转 (弧度)
    /// - Parameter radians: 弧度 0 -- 2π
    /// - Returns: 旋转后的图片
    func yex_rotated(radians: CGFloat) -> UIImage? {
        guard let weakCGImage = self.cgImage else {
            return nil
        }
        let rotateViewBox = UIView(frame: CGRect(origin: CGPoint.zero, size: self.size))
        let transform: CGAffineTransform = CGAffineTransform(rotationAngle: radians)
        rotateViewBox.transform = transform
        UIGraphicsBeginImageContext(rotateViewBox.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        context.translateBy(x: rotateViewBox.frame.width / 2, y: rotateViewBox.frame.height / 2)
        context.rotate(by: radians)
        context.scaleBy(x: 1, y: -1)
        let rect = CGRect(x: -self.size.width / 2, y: -self.size.height / 2, width: self.size.width, height: self.size.height)
        context.draw(weakCGImage, in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// 水平翻转
    /// - Returns: 返回水平翻转的图片
    func yex_flipHorizontal() -> UIImage? {
        return self.rotate(orientation: .upMirrored)
    }
    
    /// 垂直翻转
    /// - Returns: 返回垂直翻转的图片
    func yex_flipVertical() -> UIImage? {
        return self.rotate(orientation: .downMirrored)
    }
    
    /// 向下翻转
    /// - Returns: 向下翻转后的图片
    func yex_flipDown() -> UIImage? {
        return self.rotate(orientation: .down)
    }
    
    /// 向左翻转
    /// - Returns: 向左翻转后的图片
    func yex_flipLeft() -> UIImage? {
        return self.rotate(orientation: .left)
    }
    
    /// 镜像向左翻转
    /// - Returns: 镜像向左翻转后的图片
    func yex_flipLeftMirrored() -> UIImage? {
        return self.rotate(orientation: .leftMirrored)
    }
    
    /// 向右翻转
    /// - Returns: 向右翻转后的图片
    func yex_flipRight() -> UIImage? {
        return self.rotate(orientation: .right)
    }
    
    /// 镜像向右翻转
    /// - Returns: 镜像向右翻转后的图片
    func yex_flipRightMirrored() -> UIImage? {
        return self.rotate(orientation: .rightMirrored)
    }
    
    /// 图片平铺区域
    /// - Parameter size: 平铺区域的大小
    /// - Returns: 平铺后的图片
    func yex_imageTile(size: CGSize) -> UIImage? {
        let tempView = UIView(frame: CGRect(origin: CGPoint.zero, size: size))
        tempView.backgroundColor = UIColor(patternImage: self)
        UIGraphicsBeginImageContext(size)
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        tempView.layer.render(in: context)
        let bgImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return bgImage
    }
    
    /// 图片翻转(base)
    /// - Parameter orientation: 翻转类型
    /// - Returns: 翻转后的图片
    private func rotate(orientation: UIImage.Orientation) -> UIImage? {
        guard let imageRef = self.cgImage else {
            return nil
        }
        let rect = CGRect(x: 0, y: 0, width: imageRef.width, height: imageRef.height)
        var bounds = rect
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        switch orientation {
        case .up:
            return self
        case .upMirrored:
            // 图片左平移width个像素
            transform = CGAffineTransform(translationX: rect.size.width, y: 0)
            // 缩放
            transform = transform.scaledBy(x: -1, y: 1)
        case .down:
            transform = CGAffineTransform(translationX: rect.size.width, y: rect.size.height)
            transform = transform.rotated(by: CGFloat(Double.pi))
        case .downMirrored:
            transform = CGAffineTransform(translationX: 0, y: rect.size.height)
            transform = transform.scaledBy(x: 1, y: -1)
        case .left:
            swapWidthAndHeight(rect: &bounds)
            transform = CGAffineTransform(translationX:0 , y: rect.size.width)
            transform = transform.rotated(by: CGFloat(Double.pi * 1.5))
        case .leftMirrored:
            swapWidthAndHeight(rect: &bounds)
            transform = CGAffineTransform(translationX:rect.size.height , y: rect.size.width)
            transform = transform.scaledBy(x: -1, y: 1)
            transform = transform.rotated(by: CGFloat(Double.pi * 1.5))
        case .right:
            swapWidthAndHeight(rect: &bounds)
            transform = CGAffineTransform(translationX:rect.size.height , y: 0)
            transform = transform.rotated(by: CGFloat(Double.pi / 2))
        case .rightMirrored:
            swapWidthAndHeight(rect: &bounds)
            transform = transform.scaledBy(x: -1, y: 1)
            transform = transform.rotated(by: CGFloat(Double.pi / 2))
        default:
            return nil
        }
        
        UIGraphicsBeginImageContext(bounds.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        //图片绘制时进行图片修正
        switch orientation {
        case .left:
            fallthrough
        case .leftMirrored:
            fallthrough
        case .right:
            fallthrough
        case .rightMirrored:
            context.scaleBy(x: -1.0, y: 1.0)
            context.translateBy(x: -bounds.size.width, y: 0.0)
        default:
            context.scaleBy(x: 1.0, y: -1.0)
            context.translateBy(x: 0.0, y: -rect.size.height)
        }
        context.concatenate(transform)
        context.draw(imageRef, in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// 交换宽高
    /// - Parameter rect: image 的 frame
    private func swapWidthAndHeight(rect: inout CGRect) {
        let swap = rect.size.width
        rect.size.width = rect.size.height
        rect.size.height = swap
    }
}
