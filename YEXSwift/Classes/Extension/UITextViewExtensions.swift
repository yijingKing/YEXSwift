/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/yijingKing
********************************************************************************/

import Foundation
import UIKit

//MARK:   -------   属性扩展 ----------
public extension UITextView {
    private struct YEXRuntimeKey {
        static let placeholderKey = UnsafeRawPointer.init(bitPattern: "placeholder".hashValue)
        static let placeholderColorKey = UnsafeRawPointer.init(bitPattern: "placeholderColor".hashValue)
        static let placeholderEdgeKey = UnsafeRawPointer.init(bitPattern: "placeholderEdgeKey".hashValue)
    }
    //MARK: --- 占位字
    ///占位字
    var placeholder: String? {
        set {
            objc_setAssociatedObject(self, YEXRuntimeKey.placeholderKey!, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            addNotification()
        }
        get {
            return objc_getAssociatedObject(self, YEXRuntimeKey.placeholderKey!) as? String
        }
    }
    //MARK: --- 占位字颜色
    ///占位字颜色
    var placeholderColor: UIColor {
        set {
            objc_setAssociatedObject(self, YEXRuntimeKey.placeholderColorKey!, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, YEXRuntimeKey.placeholderColorKey!) as? UIColor ?? UIColor(red: 239, green: 241, blue: 247, alpha: 1)
        }
    }
    //MARK: --- 占位字
    ///占位字
    var placeholderEdgeInsets: UIEdgeInsets? {
        set {
            objc_setAssociatedObject(self, YEXRuntimeKey.placeholderEdgeKey!, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, YEXRuntimeKey.placeholderEdgeKey!) as? UIEdgeInsets
        }
    }
}

public extension UITextView {
    private func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    @objc private func textDidChange (_ tv: UITextView) {
        setNeedsDisplay()
    }
}

//MARK:   -------   重写系统方法 ----------
public extension UITextView {
    override func draw(_ rect: CGRect) {
        // 如果有文字,就直接返回,不需要画占位文字
        if hasText {
            return
        }
        // 属性
        let attrs: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: placeholderColor ,NSAttributedString.Key.font: font ?? UIFont.systemFont(ofSize: 16)]
        
        // 文字
        var rect1 = rect
        if let placeholderEdgeInsets = placeholderEdgeInsets {
            rect1.origin.x = placeholderEdgeInsets.left
            rect1.origin.y = placeholderEdgeInsets.top
            rect1.size.width = rect1.size.width - placeholderEdgeInsets.left - placeholderEdgeInsets.right
        } else {
            rect1.origin.x = 5
            rect1.origin.y = 8
            rect1.size.width = rect1.size.width - 2 * rect1.origin.x
        }
        ((placeholder ?? "") as NSString).draw(in: rect1, withAttributes: attrs)
    }
}
