/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/yijingKing
********************************************************************************/

import Foundation
import UIKit

public extension UITextField {
    ///最大字数
    func maxCount(_ count: Int) {
        self.maxCount = count
    }
    ///占位字颜色
    func placeholderColor(_ color: UIColor) {
        self.placeholderColor = color
    }
    /// 文本距离左右侧的距离
    ///
    /// - Parameters:
    ///   - leftWidth: 左侧距离
    ///   - rightWidth: 右侧距离
    func distanceSides(_ leftWidth:CGFloat,
                          _ rightWidth:CGFloat? = nil) {
        //左侧view
        let leftV = UIView(frame: CGRect(x: 0, y: 0, width: leftWidth, height: 5.auto))
        self.leftViewMode = .always
        self.leftView = leftV
        //右侧view
        let rightV = UIView(frame: CGRect(x: 0, y: 0, width: rightWidth!, height: 5.auto))
        self.rightViewMode = .always
        self.rightView = rightV
    }
    /// 添加标题
    ///
    /// - Parameters:
    ///   - titleLabel: titleLabel
    ///   - titleWidth: titleWidth
    ///   - spacing: 距离左侧的距离
    func leftView(title: String,
                   titleWidth: CGFloat,
                   color: UIColor = UIColor.black,
                   font: UIFont = UIFont.regular(size: 16),
                   textAlignment: NSTextAlignment = .left) {
        let label = UILabel()
        label.text = title
        label.textColor = color
        label.font = font
        label.textAlignment = textAlignment
        
        let height = title.getHeight(font, fixedWidth: titleWidth) + 5
        
        let leftV = UIView(frame: CGRect(x: 0, y: 0, width: titleWidth, height: height))
        label.frame = CGRect(x: 0, y: 0, width: titleWidth , height: height)
        leftV.addSubview(label)
        self.leftViewMode = .always
        self.leftView = leftV
    }
    
    /// 添加左侧icon
    ///
    /// - Parameters:
    ///   - image: image
    ///   - size: icon的size
    ///   - padding: 距离文本距离
    func leftIcon(_ image: UIImage,
                  _ size:CGSize) {
        let leftV = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let button = UIButton()
        button.image = image
        leftV.addSubview(button)
        button.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        self.leftViewMode = .always
        self.leftView = leftV
    }
    
    /// 添加标题
    ///
    /// - Parameters:
    ///   - titleLabel: titleLabel
    ///   - titleWidth: titleWidth
    ///   - spacing: 距离右侧的距离
    func rightTitle(_ title: String,
                       _ titleWidth: CGFloat,
                       _ color: UIColor? = nil,
                       _ font: UIFont? = nil,
                       block:((UIButton)->())?) {
        let button = UIButton()
        button.title = title
        button.color = color
        button.font = font
        button.addTargetAction(block: block, for: .touchUpInside)
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: titleWidth, height: 30.auto))
        button.frame = CGRect(x: 0, y: 0, width: titleWidth, height: 30.auto)
        rightView.addSubview(button)
        self.rightViewMode = .always
        self.rightView = rightView
    }
    
    /// 添加右侧icon
    ///
    /// - Parameters:
    ///   - image: image
    ///   - size: size
    ///   - padding: padding
    func rightIcon(_ image: UIImage,size:CGSize,_ block:((UIButton)->())?) {
        let rightV = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let button = UIButton()
        button.image = image
        button.addTarget(.touchUpInside, block)
        button.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        rightV.addSubview(button)
        self.rightViewMode = .always
        self.rightView = rightV
    }
    /// 方法
    /// - Parameters:
    ///   - event: 事件方式
    ///   - block: 回调
    func addTarget(_ event: UIControl.Event, _ block: ((UITextField)->())?) {
        self.allEvent(event, block)
    }
    
}

fileprivate extension UITextField {
    func allEvent(_ event: UIControl.Event, _ block: ((UITextField)->())?) {
        eventBlock = block
        self.addTarget(self, action: #selector(allEventSelects(_:)), for: event)
    }
}

private extension UITextField {
    @objc func allEventSelects(_ tf: UITextField) {
        eventBlock?(tf)
    }
    @objc func textFieldDidChange() {
        if self.maxCount > 0 {
            self.setMaxCount()
        }
    }
    ///设置最大值
    func setMaxCount() {
        let textCount = self.text?.count ?? 0
        if textCount > self.maxCount {
            self.text = String(self.text?.prefix(self.maxCount) ?? "")
        }
    }
}
fileprivate extension UITextField {
    private struct YEXRuntimeKey {
        static let maxCount = UnsafeRawPointer.init(bitPattern: "maxCount".hashValue)
        static let placeholderColor = UnsafeRawPointer.init(bitPattern: "placeholderColor".hashValue)
        static let eventBlock = UnsafeRawPointer.init(bitPattern: "eventBlock".hashValue)
    }
    ///最大字数
    var maxCount: Int {
        set {
            objc_setAssociatedObject(self, YEXRuntimeKey.maxCount!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
        get {
            return objc_getAssociatedObject(self, YEXRuntimeKey.maxCount!) as? Int ?? 0
        }
    }
    ///占位字颜色
    var placeholderColor: UIColor {
        set {
            guard let holder = self.placeholder, !holder.isEmpty else { return }
            self.attributedPlaceholder = NSAttributedString(string: holder, attributes: [.foregroundColor: newValue])
            objc_setAssociatedObject(self, YEXRuntimeKey.placeholderColor!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, YEXRuntimeKey.placeholderColor!) as? UIColor ?? UIColor.lightGray
        }
    }
    ///代理回调
    var eventBlock: ((UITextField)->())? {
        set {
            objc_setAssociatedObject(self, YEXRuntimeKey.eventBlock!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, YEXRuntimeKey.eventBlock!) as? (UITextField) -> ()
        }
    }
}
