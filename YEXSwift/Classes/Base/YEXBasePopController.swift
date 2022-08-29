/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/yijingKing
********************************************************************************/

import UIKit
import RxSwift
import RxCocoa

open class YEXBasePopController: YEXBaseViewController {
    ///点击背景隐藏(默认false)
    public var isTapToDismissEnabled: Bool = false
    
    lazy var bgBtn: UIButton = {
        let tmp = UIButton(type: .custom)
        tmp.backgroundColor = UIColor.init(white: 0, alpha: 0.8)
        tmp.addTarget(self, action: #selector(hide), for: .touchUpInside)
        return tmp
    }()
    
    public override init() {
        super.init()
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overCurrentContext
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(bgBtn)
        bgBtn.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
    
    @objc func hide() {
        if isTapToDismissEnabled {
            if let _ = parent {
                view.removeFromSuperview()
                removeFromParent()
                return
            }
            dismiss(animated: true)
        }
    }
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
}
