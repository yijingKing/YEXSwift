/*******************************************************************************
 Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ
 
 Author:        ╰莪呮想好好宠Nǐつ
 E-mail:        1091676312@qq.com
 GitHub:        https://github.com/yijingKing
 ********************************************************************************/


import Foundation
import UIKit

//MARK: --- 宏定义
/// 比例  -- Parameters: -- num: 长宽 -- proportionWidth: 比例宽(默认375)
public func YEXRatio(_ num: CGFloat,_ proportionWidth: CGFloat = 375) -> CGFloat {
    return num * YEXProportion(proportionWidth)
}
///屏幕宽
public var YEXScreenWidth: CGFloat {
    return UIScreen.main.bounds.size.width
}
///屏幕高
public var YEXScreenHeight: CGFloat {
    return UIScreen.main.bounds.size.height
}
///屏幕比例
public func YEXProportion(_ wid: CGFloat = 375) -> CGFloat {
    return UIScreen.main.bounds.size.width / wid
}
///导航高度
public var YEXNavHeight: CGFloat {
    return 44.0
}
///tabbar栏高度
public var YEXTabBarHeight: CGFloat {
    return 49.0
}
///底部安全区域
public var YEXBottomHeight: CGFloat {
    return UIApplication.shared.statusBarFrame.size.height > 20.1 ? 34.0: 0.0
}
///状态条占的高度
public var YEXStatusHeight: CGFloat {
    if #available(iOS 13.0, *) {
        return UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.size.height ?? 0
    }
    return UIApplication.shared.statusBarFrame.height
}
///导航栏高度 + 状态栏高度
public var YEXStatusAndNavHeight: CGFloat {
    return YEXStatusHeight + YEXNavHeight
}
///tabbar高度 + iphoneX多出来的高度
public var YEXBottomAndTabBarHeight: CGFloat {
    return YEXBottomHeight + YEXTabBarHeight
}
///大小
public func YEXAutoFont(_ font: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: font * YEXProportion())
}
///加粗
public func YEXAutoBoldFont(_ font: CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: font * YEXProportion())
}
///斜体
public func YEXAutoItalicSystemFont(_ font: CGFloat) -> UIFont {
    return UIFont.italicSystemFont(ofSize: font)
}
///大小
public func YEXFont(_ font: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: font)
}
///加粗
public func YEXBoldFont(_ font: CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: font)
}
///斜体
public func YEXItalicSystemFont(_ font: CGFloat) -> UIFont {
    return UIFont.italicSystemFont(ofSize: font)
}

