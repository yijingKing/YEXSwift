/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/yijingKing
********************************************************************************/

import Foundation
import UIKit

public extension YEXProtocol where T: UIFont {

    ///极细体
    static func thin(size: CGFloat) -> UIFont {
        return UIFont(name: "PingFang-SC-Thin", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    ///纤细体
    static func ultralight(size: CGFloat) -> UIFont {
        return UIFont(name: "PingFang-SC-Ultralight", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    ///中粗体
    static func semibold(size: CGFloat) -> UIFont {
        return UIFont(name: "PingFang-SC-Semibold", size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }
    ///中黑体
    static func medium(size: CGFloat) -> UIFont {
        return UIFont(name: "PingFang-SC-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    ///常规体
    static func regular(size: CGFloat) -> UIFont {
        return UIFont(name: "PingFangSC-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    static func heavy(size: CGFloat) -> UIFont {
        return UIFont(name: "PingFang-SC-Heavy", size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }
    static func bold(size: CGFloat) -> UIFont {
        return UIFont(name: "PingFang-SC-Bold", size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }
    
}
