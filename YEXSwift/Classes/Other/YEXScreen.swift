/*******************************************************************************
 Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ
 
 Author:        ╰莪呮想好好宠Nǐつ
 E-mail:        1091676312@qq.com
 GitHub:        https://github.com/yijingKing
 ********************************************************************************/


import Foundation
import UIKit

//MARK: --- 宏定义
///屏幕宽
public var YEXScreenWidth: CGFloat {
    return UIScreen.main.bounds.size.width
}
///屏幕高
public var YEXScreenHeight: CGFloat {
    return UIScreen.main.bounds.size.height
}

public struct Screen {
    public static var size: CGSize {
        return UIScreen.main.bounds.size
    }
    public static var width: Double {
        return UIScreen.main.bounds.width
    }
    public static var height: Double {
        return UIScreen.main.bounds.height
    }
    public static var scale: CGFloat {
        UIScreen.main.scale
    }
    public static var nativeScale: CGFloat {
        UIScreen.main.nativeScale
    }
}
