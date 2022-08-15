//
//  ViewController.swift
//  YEXKitDemo
//
//  Created by 祎 on 2022/7/30.
//

import UIKit
import RxSwift
import RxCocoa

import YEXSwift

class YEXViewController: YEXBaseViewController {

    var backButton: UIButton!
    
    var disposeBag = DisposeBag()
    
    
    override init () {
        super.init()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let _ = UIImage()
        let imgaeView = UILabel(text: "sadasdasd", textColor: .red, font: nil)
        imgaeView.frame = CGRect.init(x: 0, y: 0, width: 100, height: 100)
        imgaeView.center = self.view.center
        view.addSubview(imgaeView)
        backButton = UIButton()
        
        view.addSubview(backButton)
        self.backButton.isSelected = true
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        present(MallMessageViewController(), animated: true)
        
    }
}

extension Reactive where Base: UIButton {
    var isHidden: Binder<Bool> {
        return Binder(self.base) { button, hidden in
            button.isHidden = hidden
        }
    }
}
