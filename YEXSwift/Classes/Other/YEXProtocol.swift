/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/yijingKing
********************************************************************************/


import Foundation
import UIKit


/// 协议
public struct YEXProtocol<T> {
    let obj: T
    init(_ obj: T) {
        self.obj = obj
    }
}

public protocol YEXCompatible {
    associatedtype CompatibleType
    var yex: CompatibleType { get }
}
public extension YEXCompatible {
    static var yex: YEXProtocol<Self>.Type {
        get { YEXProtocol<Self>.self }
        set {}
    }
    var yex: YEXProtocol<Self> {
        return YEXProtocol(self)
    }
}

extension CGFloat: YEXCompatible {}
extension CGPoint: YEXCompatible {}
extension CGSize: YEXCompatible {}
extension CGVector: YEXCompatible {}
extension CGRect: YEXCompatible {}
extension NSObject: YEXCompatible {}
extension Array: YEXCompatible {}
extension Data: YEXCompatible {}
extension Date: YEXCompatible {}
extension String: YEXCompatible {}
extension Int: YEXCompatible {}
extension Dictionary: YEXCompatible {}
extension Float: YEXCompatible {}
extension Set: YEXCompatible {}
extension Double: YEXCompatible {}
extension DateComponents: YEXCompatible {}
