/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/yijingKing
********************************************************************************/

import Foundation

public var SafeDistanceTop: Double {
    return UIDevice.safeDistanceTop
}
public var SafeDistanceBottom: Double {
    return UIDevice.safeDistanceBottom
}
public var navigationFullHeight: Double {
    return UIDevice.navigationFullHeight
}

public extension UIDevice {
    /// 顶部安全区高度
    static var safeDistanceTop: Double {
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            guard let windowScene = scene as? UIWindowScene else { return 0 }
            guard let window = windowScene.windows.first else { return 0 }
            return window.safeAreaInsets.top
        } else if #available(iOS 11.0, *) {
            guard let window = UIApplication.shared.windows.first else { return 0 }
            return window.safeAreaInsets.top
        }
        return 0;
    }
    
    /// 底部安全区高度
    static var safeDistanceBottom: Double {
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            guard let windowScene = scene as? UIWindowScene else { return 0 }
            guard let window = windowScene.windows.first else { return 0 }
            return window.safeAreaInsets.bottom
        } else if #available(iOS 11.0, *) {
            guard let window = UIApplication.shared.windows.first else { return 0 }
            return window.safeAreaInsets.bottom
        }
        return 0
    }
    
    /// 顶部状态栏高度（包括安全区）
    static var statusBarHeight: Double {
        var statusBarHeight: CGFloat = 0
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            guard let windowScene = scene as? UIWindowScene else { return 0 }
            guard let statusBarManager = windowScene.statusBarManager else { return 0 }
            statusBarHeight = statusBarManager.statusBarFrame.height
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        return statusBarHeight
    }
    
    /// 导航栏高度
    static var navigationBarHeight: Double {
        return 44.0
    }
    
    /// 状态栏+导航栏的高度
    static var navigationFullHeight: Double {
        return UIDevice.statusBarHeight + UIDevice.navigationBarHeight
    }
    
    /// 底部导航栏高度
    static var tabBarHeight: Double {
        return 49.0
    }
    
    /// 底部导航栏高度（包括安全区）
    static var tabBarFullHeight: Double {
        return UIDevice.tabBarHeight + UIDevice.safeDistanceBottom
    }
}

