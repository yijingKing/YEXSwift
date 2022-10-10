/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/yijingKing
********************************************************************************/

import UIKit
@_exported import SnapKit
@_exported import RxSwift
@_exported import RxCocoa

open class YEXBaseViewController: UIViewController {

    /// 视图
    public var completion: (() -> Void)?
    
    //MARK: --- 状态栏
    private var _barStyle: UIStatusBarStyle?
    ///状态栏
    public var barStyle: UIStatusBarStyle {
        set {
            _barStyle = newValue
            setNeedsStatusBarAppearanceUpdate()
        }
        get {
            return _barStyle ?? UIStatusBarStyle.default
        }
    }
    /// 导航视图
    public lazy var customNavigationView: UIView = {
        let tmp = UIView()
        return tmp
    }()
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        completion?()
    }
    
    //MARK: --- viewDidLoad
    open override func viewDidLoad() {
        super.viewDidLoad()
        print("当前页面:" + "\(self.self)")
        
        view.backgroundColor = UIColor.yex.hexF2F2F2
        
        view.addSubview(customNavigationView)
        customNavigationView.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.bottom.equalTo(view.snp.topMargin)
            make.top.equalTo(view)
        }
        
#if DEBUG
        NotificationCenter.default.addObserver(self, selector: #selector(injectionNotifications), name: NSNotification.Name("INJECTION_BUNDLE_NOTIFICATION"), object: nil)
#endif
        
    }
    
    @objc func injectionNotifications () {
        viewDidLoad()
    }
    
    @objc func injected() {

    }

    /// 添加控制器
    public func addChildController(_ childController: UIViewController) {
        addChild(childController)
        view.addSubview(childController.view)
        childController.didMove(toParent: self)
    }
    /// 移除添加的控制器
    public func removeChildController() {
        guard parent != nil else { return }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
    
    deinit {
        print("--\(self.self)---控制器销毁")
        NotificationCenter.default.removeObserver(self)
    }
}

//MARK: --- 系统方法重写
extension YEXBaseViewController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return barStyle
    }
    
}

