/*******************************************************************************
 Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ
 
 Author:        ╰莪呮想好好宠Nǐつ
 E-mail:        1091676312@qq.com
 GitHub:        https://github.com/yijingKing
 ********************************************************************************/


import Foundation
import UIKit

public var ScreenWidth: Double {
    return Screen.width
}
public var ScreenHeight: Double {
    return Screen.height
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
    public static var scale: Double {
        UIScreen.main.scale
    }
    public static var nativeScale: Double {
        UIScreen.main.nativeScale
    }
}
