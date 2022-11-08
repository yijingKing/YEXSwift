/*******************************************************************************
 Copyright (K), 2019 - ~, ╰莪呮想好好宠Nǐつ
 
 Author:        ╰莪呮想好好宠Nǐつ
 E-mail:        1091676312@qq.com
 GitHub:        https://github.com/yijingKing
 *******************************************************************************/

import Foundation

public extension UIScrollView {
    /// 保存为图片
    func getImageByUIGraphic() -> UIImage? {
        // 为了防止内存不能被及时释放，导致系统内存告急，因此在外面加一层自动释放池
        autoreleasepool {
            // 设置截图大小
            let scrollView = self

            // 保存当前的偏移量
            let previousContentOffset = scrollView.contentOffset
            let previousFrame = scrollView.frame

            // 将偏移量设置为(0,0)
            scrollView.contentOffset = CGPoint.zero
            scrollView.frame = CGRect(x: 0, y: 0, width: scrollView.contentSize.width, height: scrollView.contentSize.height)

            // ---------- start -------------
            // 指定大小、透明度和缩放
            UIGraphicsBeginImageContextWithOptions(scrollView.contentSize , true, 0)

            // 在当前上下文中渲染出整个内容
            if let context = UIGraphicsGetCurrentContext() {
                scrollView.layer.render(in: context)
            }
            // 截取当前上下文，生成Image
            let image = UIGraphicsGetImageFromCurrentImageContext()

            // 关闭图形上下文
            UIGraphicsEndImageContext()
            // ---------- end --------------

            // 注意：恢复偏移量
            scrollView.contentOffset = previousContentOffset
            scrollView.frame = previousFrame

            return image
        }
    }
}
