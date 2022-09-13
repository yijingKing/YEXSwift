/*******************************************************************************
 Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ
 
 Author:        ╰莪呮想好好宠Nǐつ
 E-mail:        1091676312@qq.com
 GitHub:        https://github.com/yijingKing
 ********************************************************************************/

import UIKit
import Foundation

public extension YEXProtocol where T: UIViewController {
   
    /// 系统提示弹窗
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 消息
    ///   - buttonTitles: 按钮文本组
    ///   - highlightedButtonIndex: 高亮按钮
    ///   - completion: 事件返回
    /// - Returns: 弹窗控制器
    @discardableResult
    func showAlert(title: String?, message: String?, buttonTitles: [String]? = nil, highlightedButtonIndex: Int? = nil, completion: ((Int) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var allButtons = buttonTitles ?? [String]()
        if allButtons.count == 0 {
            allButtons.append("OK")
        }

        for index in 0..<allButtons.count {
            let buttonTitle = allButtons[index]
            let action = UIAlertAction(title: buttonTitle, style: .default, handler: { (_) in
                completion?(index)
            })
            alertController.addAction(action)
            
            if let highlightedButtonIndex = highlightedButtonIndex, index == highlightedButtonIndex {
                alertController.preferredAction = action
            }
        }
        obj.present(alertController, animated: true, completion: nil)
        return alertController
    }
    
    
}
