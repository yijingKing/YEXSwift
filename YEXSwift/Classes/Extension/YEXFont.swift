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
    func thin(size: CGFloat) -> UIFont {
        return UIFont(name: "PingFang-SC-Thin", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    ///纤细体
    func ultralight(size: CGFloat) -> UIFont {
        return UIFont(name: "PingFang-SC-Ultralight", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    ///中粗体
    func semibold(size: CGFloat) -> UIFont {
        return UIFont(name: "PingFang-SC-Semibold", size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }
    ///中黑体
    func medium(size: CGFloat) -> UIFont {
        return UIFont(name: "PingFang-SC-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    ///常规体
    func regular(size: CGFloat) -> UIFont {
        return UIFont(name: "PingFangSC-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    func heavy(size: CGFloat) -> UIFont {
        return UIFont(name: "PingFang-SC-Heavy", size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }
    func bold(size: CGFloat) -> UIFont {
        return UIFont(name: "PingFang-SC-Bold", size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }
    
}
