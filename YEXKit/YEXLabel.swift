/*******************************************************************************
Copyright (K), 2022 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/MemoryKing
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


