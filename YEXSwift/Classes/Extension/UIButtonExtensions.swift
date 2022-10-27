/*******************************************************************************
 Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ
 
 Author:        ╰莪呮想好好宠Nǐつ
 E-mail:        1091676312@qq.com
 GitHub:        https://github.com/yijingKing
 ********************************************************************************/


import UIKit

public extension UIButton {
    ///标题
    var title: String? {
        set {
            setTitle(newValue, for: .normal)
        }
        get {
            return title(for: .normal)
        }
    }
    ///字体
    var font: UIFont? {
        set {
            titleLabel?.font = newValue
        }
        get {
            return titleLabel?.font
        }
    }
    ///字体颜色
    var color: UIColor? {
        set {
            setTitleColor(newValue, for: .normal)
        }
        get {
            return titleColor(for: .normal)
        }
    }
    ///选中文本
    var selectedTitle: String? {
        set {
            setTitle(newValue, for: .selected)
        }
        get {
            return title(for: .selected)
        }
    }
    ///选中颜色
    var selectedColor: UIColor? {
        set {
            setTitleColor(newValue, for: .selected)
        }
        get {
            return titleColor(for: .selected)
        }
    }
    ///富文本
    var attributedTitle: NSAttributedString? {
        set {
            setAttributedTitle(newValue, for: .normal)
        }
        get {
            return attributedTitle(for: .normal)
        }
    }
    ///富文本
    var selectedAttributedTitle: NSAttributedString? {
        set {
            setAttributedTitle(newValue, for: .selected)
        }
        get {
            return attributedTitle(for: .selected)
        }
    }
    ///文本阴影
    var titleShadowColor: UIColor? {
        set {
            setTitleShadowColor(newValue, for: .normal)
        }
        get {
            return titleShadowColor(for: .normal)
        }
    }
    ///文本阴影
    var selectedTitleShadowColor: UIColor? {
        set {
            setTitleShadowColor(newValue, for: .selected)
        }
        get {
            return titleShadowColor(for: .selected)
        }
    }
    ///图片
    var image: UIImage? {
        set {
            setImage(newValue?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        get {
            return image(for: .normal)
        }
    }
    ///选中图片
    var selectedImage: UIImage? {
        set {
            setImage(newValue?.withRenderingMode(.alwaysOriginal), for: .selected)
        }
        get {
            return image(for: .selected)
        }
    }
    ///背景图
    var backgroundImage: UIImage? {
        set {
            setBackgroundImage(newValue?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        get {
            return backgroundImage(for: .normal)
        }
    }
    ///选中背景图
    var selectedBackgroundImage: UIImage? {
        set {
            setBackgroundImage(newValue?.withRenderingMode(.alwaysOriginal), for: .selected)
        }
        get {
            return backgroundImage(for: .selected)
        }
    }
    
}

public extension YEXProtocol where T: UIButton {
    ///点击
    func addTarget(_ block:((UIButton)->())?) {
        obj.addTargetAction(block: block, for: .touchUpInside)
    }
    ///点击
    func addTarget(_ taget: UIControl.Event = .touchUpInside,_ block:((UIButton)->())?) {
        obj.addTargetAction(block: block, for: taget)
    }
}

public enum YEXButtonImagePosition: Int {
    case left       = 0x0
    case right      = 0x01
    case top        = 0x02
    case bottom     = 0x03
}

public extension YEXProtocol where T: UIButton {
    //MARK: --- 图片文本位置
    /// 图片文本位置
    /// - Parameters:
    ///   - type: 图片位置
    ///   - imageWidth: 图片大小
    ///   - space: 间距
    func imagePosition(_ type: YEXButtonImagePosition,_ space: CGFloat? = nil,_ imageW: CGFloat? = nil,_ imageH: CGFloat? = nil){
        var image: UIImage?
        if let w = imageW, let h = imageH {
            image = image?.yex.scale(w, h)
            obj.setImage(image, for: .normal)
        }
        guard let imageWidth = obj.imageView?.image?.size.width,
              let imageHeight = obj.imageView?.image?.size.height else { return }
        
        guard var titleWidth = obj.titleLabel?.text?.yex.getWidth(obj.titleLabel?.font ?? UIFont.systemFont(ofSize: 17)) else { return }
        let width = CGFloat(obj.width)
        if titleWidth >= width {
            titleWidth = width
        }
        
        let titleHeight = obj.titleLabel?.font.pointSize ?? 0
        let insetAmount = (space ?? 0) / 2
        let imageOffWidth = (imageWidth + titleWidth) / 2 - imageWidth / 2
        let imageOffHeight = imageHeight / 2 + insetAmount
        let titleOffWidth = imageWidth + titleWidth / 2 - (imageWidth + titleWidth) / 2
        let titleOffHeight = titleHeight / 2 + insetAmount
        switch type {
        case .left:
            obj.imageEdgeInsets = .init(top: 0, left: -insetAmount,
                                        bottom: 0, right: insetAmount)
            obj.titleEdgeInsets = .init(top: 0, left: insetAmount,
                                        bottom: 0, right: -insetAmount)
            obj.contentHorizontalAlignment = .center
        case .right:
            obj.imageEdgeInsets = .init(top: 0, left: titleWidth + insetAmount,
                                        bottom: 0, right: -(titleWidth + insetAmount))
            obj.titleEdgeInsets = .init(top: 0, left: -(imageWidth + insetAmount),
                                        bottom: 0, right: imageWidth + insetAmount)
            obj.contentHorizontalAlignment = .center
        case .top:
            obj.imageEdgeInsets = .init(top: -imageOffHeight, left: imageOffWidth,
                                        bottom: imageOffHeight, right: -imageOffWidth)
            obj.titleEdgeInsets = .init(top: titleOffHeight, left: -titleOffWidth,
                                        bottom: -titleOffHeight, right: titleOffWidth)
            obj.contentVerticalAlignment = .center
        case .bottom:
            obj.imageEdgeInsets = .init(top: imageOffHeight, left: imageOffWidth,
                                        bottom: -imageOffHeight, right: -imageOffWidth)
            obj.titleEdgeInsets = .init(top: -titleOffHeight, left: -titleOffWidth,
                                        bottom: titleOffHeight, right: titleOffWidth)
            obj.contentVerticalAlignment = .center
        }
    }
}

//MARK: --- 点击
public extension UIButton {
    struct YEXRuntimeKey {
        static let YEXButtonClick = UnsafeRawPointer.init(bitPattern: "YEXButtonClick".hashValue)
    }
    ///点击
    var action: ((UIButton)->())? {
        set {
            objc_setAssociatedObject(self, YEXRuntimeKey.YEXButtonClick!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, YEXRuntimeKey.YEXButtonClick!) as? (UIButton) -> ()
        }
    }
    func addTargetAction(block: ((UIButton)->())?, for controlEvents: UIControl.Event) {
        action = block
        addTarget(self, action: #selector(buttonAction(_:)), for: controlEvents)
    }
    @objc private func buttonAction(_ button: UIButton) {
        action?(button)
    }
}

