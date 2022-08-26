/*******************************************************************************
 Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ
 
 Author:        ╰莪呮想好好宠Nǐつ
 E-mail:        1091676312@qq.com
 GitHub:        https://github.com/yijingKing
 ********************************************************************************/


import Foundation
import UIKit

//MARK: --- 获取属性和方法
public extension YEXProtocol where T: NSObject {
    
    //MARK: --- 获取类的属性列表
    /// 获取类的属性列表
    func get_class_copyPropertyList() -> [String] {
        var outCount:UInt32 = 0
        let propers:UnsafeMutablePointer<objc_property_t>! =  class_copyPropertyList(obj.classForCoder, &outCount)
        let count:Int = Int(outCount);
        var names:[String] = [String]()
        for i in 0...(count-1) {
            let aPro: objc_property_t = propers[i]
            if let proName:String = String(utf8String: property_getName(aPro)){
                names.append(proName)
            }
        }
        return names
    }
    //MARK: --- 获取类的方法列表
    /// 获取类的方法列表
    func get_class_copyMethodList() -> [String] {
        var outCount:UInt32
        outCount = 0
        let methods:UnsafeMutablePointer<objc_property_t>! =  class_copyMethodList(obj.classForCoder, &outCount)
        let count:Int = Int(outCount);
        var names:[String] = [String]()
        for i in 0...(count-1) {
            let aMet: objc_property_t = methods[i]
            if let methodName:String = String(utf8String: property_getName(aMet)){
                names.append(methodName)
            }
        }
        return names
    }
    ///获取当前控制器
    func getTopViewController () -> UIViewController? {
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first, let rootVC = window.rootViewController  else {
            return nil
        }
        return Self.top(rootVC: rootVC)
    }
    private static func top(rootVC: UIViewController?) -> UIViewController? {
        if let presentedVC = rootVC?.presentedViewController {
            return top(rootVC: presentedVC)
        }
        if let nav = rootVC as? UINavigationController,
            let lastVC = nav.viewControllers.last {
            return top(rootVC: lastVC)
        }
        if let tab = rootVC as? UITabBarController,
            let selectedVC = tab.selectedViewController {
            return top(rootVC: selectedVC)
        }
        return rootVC
    }
}

public class AssociatedWrapper<Base> {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

public protocol AssociatedCompatible {
    associatedtype AssociatedCompatibleType
    var associated: AssociatedCompatibleType { get }
}

extension AssociatedCompatible {
    public var associated: AssociatedWrapper<Self> {
        get { return AssociatedWrapper(self) }
    }
}

extension NSObject: AssociatedCompatible { }
public extension AssociatedWrapper where Base: NSObject {
    
    enum Policy {
        case nonatomic
        case atomic
    }
    
    /// 获取关联值
    func get<T>(_ key: UnsafeRawPointer) -> T? {
        objc_getAssociatedObject(base, key) as? T
    }
    
    /// 设置关联值 OBJC_ASSOCIATION_ASSIGN
    func set(assign key: UnsafeRawPointer, _ value: Any) {
        objc_setAssociatedObject(base, key, value, .OBJC_ASSOCIATION_ASSIGN)
    }
    
    /// 设置关联值 OBJC_ASSOCIATION_RETAIN_NONATOMIC / OBJC_ASSOCIATION_RETAIN
    func set(retain key: UnsafeRawPointer, _ value: Any?, _ policy: Policy = .nonatomic) {
        switch policy {
        case .nonatomic:
            objc_setAssociatedObject(base, key, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        case .atomic:
            objc_setAssociatedObject(base, key, value, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    /// 设置关联值 OBJC_ASSOCIATION_COPY_NONATOMIC / OBJC_ASSOCIATION_COPY
    func set(copy key: UnsafeRawPointer, _ value: Any?, _ policy: Policy = .nonatomic) {
        switch policy {
        case .nonatomic:
            objc_setAssociatedObject(base, key, value, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        case .atomic:
            objc_setAssociatedObject(base, key, value, .OBJC_ASSOCIATION_COPY)
        }
    }
}

//MARK: --- 宏定义
/// 比例  -- Parameters: -- num: 长宽 -- proportionWidth: 比例宽(默认375)
public func YEXRatio(_ num: CGFloat,_ proportionWidth: CGFloat = 375) -> CGFloat {
    return num * YEXProportion(proportionWidth)
}
///屏幕宽
public var YEXScreenWidth: CGFloat {
    return UIScreen.main.bounds.size.width
}
///屏幕高
public var YEXScreenHeight: CGFloat {
    return UIScreen.main.bounds.size.height
}
///屏幕比例
public func YEXProportion(_ wid: CGFloat = 375) -> CGFloat {
    return UIScreen.main.bounds.size.width / wid
}
///导航高度
public var YEXNavHeight: CGFloat {
    return 44.0
}
///tabbar栏高度
public var YEXTabBarHeight: CGFloat {
    return 49.0
}
///底部安全区域
public var YEXBottomHeight: CGFloat {
    return UIApplication.shared.statusBarFrame.size.height > 20.1 ? 34.0: 0.0
}
///状态条占的高度
public var YEXStatusHeight: CGFloat {
    if #available(iOS 13.0, *) {
        return UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.size.height ?? 0
    }
    return UIApplication.shared.statusBarFrame.height
}
///导航栏高度 + 状态栏高度
public var YEXStatusAndNavHeight: CGFloat {
    return YEXStatusHeight + YEXNavHeight
}
///tabbar高度 + iphoneX多出来的高度
public var YEXBottomAndTabBarHeight: CGFloat {
    return YEXBottomHeight + YEXTabBarHeight
}
///大小
public func YEXAutoFont(_ font: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: font * YEXProportion())
}
///加粗
public func YEXAutoBoldFont(_ font: CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: font * YEXProportion())
}
///斜体
public func YEXAutoItalicSystemFont(_ font: CGFloat) -> UIFont {
    return UIFont.italicSystemFont(ofSize: font)
}
///大小
public func YEXFont(_ font: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: font)
}
///加粗
public func YEXBoldFont(_ font: CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: font)
}
///斜体
public func YEXItalicSystemFont(_ font: CGFloat) -> UIFont {
    return UIFont.italicSystemFont(ofSize: font)
}

