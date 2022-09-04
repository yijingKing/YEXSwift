/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/yijingKing
********************************************************************************/


import UIKit
import SnapKit

open class YEXBaseViewController: UIViewController {

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
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overFullScreen
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: --- viewDidLoad
    open override func viewDidLoad() {
        super.viewDidLoad()
        print("当前页面:" + "\(self.self)")
        
        extendedLayoutIncludesOpaqueBars = true
        
        view.backgroundColor = UIColor.white
        
        
#if DEBUG
        NotificationCenter.default.addObserver(self, selector: #selector(injectionNotifications), name: NSNotification.Name("INJECTION_BUNDLE_NOTIFICATION"), object: nil)
#endif
        
    }
    
    @objc func injectionNotifications () {
        viewDidLoad()
    }
    
    @objc func injected() {
//        viewDidLoad()
    }
    ///侧滑开始
    open func willMode() { }
    ///侧滑结束
    open func didMove() { }
    
}

//MARK: --- 系统方法重写
extension YEXBaseViewController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return barStyle
    }
    
    open override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        guard let _ = parent else {
            willMode()
            return
        }
    }
    
    open override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        guard let _ = parent else {
            didMove()
            return
        }
    }
}

