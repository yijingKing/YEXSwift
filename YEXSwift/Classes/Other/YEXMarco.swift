/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/yijingKing
********************************************************************************/


import Foundation

/// 屏幕宽
public var ScreenWidth: Double {
    return YEXScreen.width
}
/// 屏幕高
public var ScreenHeight: Double {
    return YEXScreen.height
}
/// 顶部安全区高度
public var SafeDistanceTop: Double {
    return UIDevice.yex.safeDistanceTop
}
/// 底部安全区高度
public var SafeDistanceBottom: Double {
    return UIDevice.yex.safeDistanceBottom
}
/// 状态栏+导航栏的高度
public var NavigationFullHeight: Double {
    return UIDevice.yex.navigationFullHeight
}
/// 底部导航栏高度（包括安全区）
public var TabBarFullHeight: Double {
    return UIDevice.yex.tabBarFullHeight
}
/// 底部导航栏高度
public var TabBarHeight: Double {
    return UIDevice.yex.tabBarHeight
}
