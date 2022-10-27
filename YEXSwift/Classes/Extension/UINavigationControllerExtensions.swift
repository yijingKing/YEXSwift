/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/yijingKing
********************************************************************************/


import Foundation

public extension UINavigationController {
    private struct RuntimeKey {
        static let TitleViewKey = UnsafeRawPointer.init(bitPattern: "TitleViewKey".hashValue)
    }
    fileprivate var titleView: UIView? {
        set {
            objc_setAssociatedObject(self, RuntimeKey.TitleViewKey!, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            guard let newValue else { return }
            let titleViewBG = UIView(frame: .init(x: 0, y: 0, width: newValue.width, height: newValue.height))
            if #available(iOS 16.0, *) {
                titleViewBG.addSubview(newValue)
                navigationItem.titleView = titleViewBG
            } else {
                navigationItem.titleView = newValue
            }
        }
        get {
            objc_getAssociatedObject(self, RuntimeKey.TitleViewKey!) as? UIView
        }
    }
}

public extension YEXProtocol where T: UINavigationController {
    /// 设置导航标题视图(适配iOS16标题视图设置alpha无效)
    func setTitleView(_ titleView: UIView) {
        obj.titleView = titleView
    }
    
    /// 跳转
    /// - Parameters:
    ///   - vc: 跳转的控制器
    ///   - deleteClass: 删除控制器
    ///   - compelete: 完成
    func push<T>(vc: UIViewController, deleteClass: T.Type, compelete:(() -> Void)? = nil) {
        obj.yex.pushViewController(vc) { [weak obj] in
            guard let this = obj else { return }
            var list = this.viewControllers
            list.removeAll { ele in
                return ele is T
            }
            this.setViewControllers(list, animated: false)
            compelete?()
        }
    }
    /// 返回
    /// - Parameters:
    ///   - deleteClass: 删除控制器
    ///   - compelete: 完成
    func pop<T>(deleteClass: T.Type, compelete:(() -> Void)? = nil) {
        obj.yex.popViewController(animated: true) { [weak obj] in
            guard let this = obj else { return }
            var list = this.viewControllers
            list.removeAll { ele in
                return ele is T
            }
            this.setViewControllers(list, animated: false)
            compelete?()
        }
    }
    /// 返回
    /// - Parameters:
    ///   - deleteClass: 删除控制器
    ///   - compelete: 完成
    func dismiss<T>(deleteClass: T.Type, compelete:(() -> Void)? = nil) {
        obj.dismiss(animated: true) { [weak obj] in
            guard let this = obj else { return }
            var list = this.viewControllers
            list.removeAll { ele in
                return ele is T
            }
            this.setViewControllers(list, animated: false)
            compelete?()
        }
    }
    
    func popViewController(animated: Bool = true, _ completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        obj.popViewController(animated: animated)
        CATransaction.commit()
    }
    
    func pushViewController(_ viewController: UIViewController, completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        obj.pushViewController(viewController, animated: true)
        CATransaction.commit()
    }
}
