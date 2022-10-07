/*******************************************************************************
 Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ
 
 Author:        ╰莪呮想好好宠Nǐつ
 E-mail:        1091676312@qq.com
 GitHub:        https://github.com/yijingKing
 ********************************************************************************/


import Foundation
import UIKit

public struct YEXScreen {
    /// 屏幕大小
    public static var size: CGSize {
        return UIScreen.main.bounds.size
    }
    /// 屏幕宽
    public static var width: Double {
        return UIScreen.main.bounds.width
    }
    /// 屏幕高
    public static var height: Double {
        return UIScreen.main.bounds.height
    }
    /// 屏幕比例
    public static var scale: Double {
        UIScreen.main.scale
    }
    /// 物理屏幕比例
    public static var nativeScale: Double {
        UIScreen.main.nativeScale
    }
}
