/*******************************************************************************
Copyright (K), 2022 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/yijingKing
********************************************************************************/

import Foundation
import UIKit

// MARK: - 初始化
public extension UILabel {
    /// 初始化
    /// - Parameters:
    ///   - text: 文本
    ///   - textColor: 颜色
    ///   - font: 字体
    convenience init(text: String? = "", textColor: UIColor? = .black, font: UIFont? = .systemFont(ofSize: 16)) {
        self.init(frame: .zero, text: text, textColor: textColor, font: font)
        self.text = text
        if let color = textColor {
            self.textColor = color
        }
        if let fo = font {
            self.font = fo
        }
    }
    
    /// 初始化
    /// - Parameters:
    ///   - frame: 位置
    ///   - text: 文本
    ///   - textColor: 颜色
    ///   - font: 字体
    convenience init(frame: CGRect? = CGRect.zero,text: String? = "",textColor: UIColor? = .black,font: UIFont? = .systemFont(ofSize: 16)) {
        self.init(frame: CGRect.zero)
        self.text = text
        if let color = textColor {
            self.textColor = color
        }
        if let fo = font {
            self.font = fo
        }
    }
}
// MARK:--- 基本的扩展
public extension YEXProtocol where T: UILabel {
    ///字体大小
    func font(_ font: CGFloat,_ weight: UIFont.Weight? = nil) {
        obj.font = UIFont.systemFont(ofSize: font, weight: weight ?? .medium)
    }
    ///加粗字体大小
    func boldFont(_ font: CGFloat) {
        obj.font = UIFont.boldSystemFont(ofSize: font)
    }
    
    ///开启长按复制
    func isOpenCopy(_ isCopy: Bool) {
        obj.isUserInteractionEnabled = true
        let LongPress = UILongPressGestureRecognizer(target: obj, action: #selector(obj.longPressCopyEvent))
        obj.addGestureRecognizer(LongPress)
    }

    /// 改变字间距
    ///
    /// - Parameter space: space
    func wordSpace(_ space: Float) {
        guard let labelText = obj.text else {
            return
        }
        let attStr = NSMutableAttributedString.init(string: labelText)
        attStr.addAttribute(NSAttributedString.Key.kern, value: (space), range: NSMakeRange(0, labelText.count))
        attStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: NSMutableParagraphStyle.init(), range: NSMakeRange(0, labelText.count))
        obj.attributedText = attStr
        obj.sizeToFit()
    }
    
    /// 改变行间距
    ///
    /// - Parameter space: space
    func lineSpace(_ space: Float) {
        guard let labelText = obj.text else {
            return
        }
        let attStr = NSMutableAttributedString.init(string: labelText)
        let paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = CGFloat(space)
        attStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, labelText.count))
        obj.attributedText = attStr
        obj.sizeToFit()
    }
    
    /// 改变行间距和字间距
    ///
    /// - Parameters:
    ///   - lineSpace: 行间距
    ///   - wordSpace: 字间距
    func lineSpaceWithWordSpace(_ lineSpace:Float,_ wordSpace:Float) {
        guard let labelText = obj.text else {
            return
        }
        let attStr = NSMutableAttributedString.init(string: labelText)
        let paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = CGFloat(lineSpace)
        attStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, labelText.count))
        attStr.addAttribute(NSAttributedString.Key.kern, value: (wordSpace), range: NSMakeRange(0, labelText.count))
        obj.attributedText = attStr
        obj.sizeToFit()
    }
}

//MARK: --- 初始化
public extension UILabel {

    @objc func longPressCopyEvent(){
        // 让其成为响应者
        becomeFirstResponder()
        // 拿出菜单控制器单例
        let menu = UIMenuController.shared
        // 创建一个复制的item
        let copy = UIMenuItem(title: "copy", action: #selector(copyText))
        // 将复制的item交给菜单控制器（菜单控制器其实可以接受多个操作）
        menu.menuItems = [copy]
        // 设置菜单控制器的点击区域为这个控件的bounds
        menu.setTargetRect(bounds, in: self)
        // 显示菜单控制器，默认是不可见状态
        menu.setMenuVisible(true, animated: true)
    }
    
    @objc func copyText() {
        if let t = text {
            UIPasteboard.general.string = t
        }
    }
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        if action == #selector(copyText) {
            return true
        } else {
            return false
        }
    }
    
    /// 拥有成为响应者的能力
    override var canBecomeFirstResponder: Bool{
        return true
    }
}

