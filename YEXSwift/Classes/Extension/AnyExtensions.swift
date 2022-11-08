/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/yijingKing
********************************************************************************/

import UIKit


extension NSObject: YEXJSON{}

public protocol YEXJSON {}

public extension YEXJSON {
    var json: String? {
        guard JSONSerialization.isValidJSONObject(self) else {
            YEXPrint("json转换失败")
            return nil
        }
        //如果设置options为JSONSerialization.WritingOptions.prettyPrinted，则打印格式更好阅读
        let jsonData = try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted])

        if let jsonData = jsonData {
            let str = String(data: jsonData, encoding: String.Encoding.utf8)
            return str
        }else {
           return nil
        }
    }
}
