/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/yijingKing
********************************************************************************/

import Foundation
import UIKit

public extension YEXProtocol where T: UITabBarController {
    /// 设置背景颜色
    func setTabbarBgColor(_ color: UIColor) {
        if #available(iOS 13.0, *) {
            let app = obj.tabBar.standardAppearance.copy()
            app.backgroundColor = color
            app.backgroundImage = UIImage.init(color: color, size: CGSize(width: 1, height: 1))
            obj.tabBar.standardAppearance = app
            if #available(iOS 15.0, *) {
                obj.tabBar.scrollEdgeAppearance = app
            }
        } else {
            obj.tabBar.barTintColor = color
            obj.tabBar.shadowImage = UIImage()
        }
    }
    
    /// 标题偏移
    func setTabbarTitlePositionAdjustment(offset: UIOffset) {
        
        if #available(iOS 13.0, *) {
            let app = obj.tabBar.standardAppearance.copy()
            app.stackedLayoutAppearance.normal.titlePositionAdjustment = offset
            app.stackedLayoutAppearance.selected.titlePositionAdjustment = offset
            obj.tabBar.standardAppearance = app
            if #available(iOS 15.0, *) {
                obj.tabBar.scrollEdgeAppearance = app
            }
        } else {
            UITabBarItem.appearance().titlePositionAdjustment = offset
        }
    }
}


