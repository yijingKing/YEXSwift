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
        tmp.backgroundColor = .clear
        tmp.addTarget(self, action: #selector(hide), for: .touchUpInside)
        return tmp
    }()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overFullScreen
    }
    public required init?(coder: NSCoder) {
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
    
}
