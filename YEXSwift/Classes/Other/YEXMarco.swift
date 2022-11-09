/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/yijingKing
********************************************************************************/


import Foundation

/// 屏幕宽
public var YEXScreenWidth: Double {
    return YEXScreen.width
}
/// 屏幕高
public var YEXScreenHeight: Double {
    return YEXScreen.height
}
/// 顶部安全区高度
public var YEXSafeDistanceTop: Double {
    return UIDevice.safeDistanceTop
}
/// 底部安全区高度
public var YEXSafeDistanceBottom: Double {
    return UIDevice.safeDistanceBottom
}
/// 状态栏+导航栏的高度
public var YEXNavigationFullHeight: Double {
    return UIDevice.navigationFullHeight
}
/// 底部导航栏高度（包括安全区）
public var YEXTabBarFullHeight: Double {
    return UIDevice.tabBarFullHeight
}
/// 底部导航栏高度
public var YEXTabBarHeight: Double {
    return UIDevice.tabBarHeight
}

public func YEXPrint(_ text: Any?) {
    print("""
    ╔═══════ 🎈 YEXSwift 🎈 ═══════
    ║ \(text ?? "")
    ╚═══════════════════════════════════
    """)
}
