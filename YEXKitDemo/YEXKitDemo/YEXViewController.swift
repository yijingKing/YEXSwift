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
    
    var isSelect = false
    var dataList = BehaviorSubject(value: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let _ = UIImage()
        let imgaeView = UILabel(text: "", textColor: .red, font: nil)
        imgaeView.frame = CGRect.init(x: 0, y: 0, width: 300, height: 100)
        imgaeView.center = self.view.center
        view.addSubview(imgaeView)
        backButton = UIButton()
        
        view.addSubview(backButton)
        self.backButton.isSelected = true
        
        imgaeView.attributedText = "".yex.setOutline(font: .systemFont(ofSize: 25), alignment: .center, textColor: .blue, strokeWidth: -4, widthColor: .red)
        
        dataList.asObserver().bind(with: self.backButton) { btn, bool in
            btn.isSelected = bool
            print(btn.isSelected)
            print(bool)
            
        }.disposed(by: disposeBag)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        present(MallMessageViewController(), animated: true)
        dataList.onNext(!self.backButton.isSelected)
    }
    
    
}

extension Reactive where Base: UIButton {
    var isHidden: Binder<Bool> {
        return Binder(self.base) { button, hidden in
            button.isHidden = hidden
        }
    }
}
