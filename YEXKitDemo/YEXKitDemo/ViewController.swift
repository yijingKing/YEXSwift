//
//  ViewController.swift
//  YEXKitDemo
//
//  Created by 祎 on 2022/7/30.
//

import UIKit
import RxSwift
import RxCocoa


class ViewController: UIViewController {

    var backButton: UIButton!
    
    var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        _ image = UIImage(color: .red, size: .init(width: 100, height: 100))
        let imgaeView = UILabel(text: "sadasdasd", textColor: .red, font: nil)
        imgaeView.frame = CGRect.init(x: 0, y: 0, width: 100, height: 100)
        imgaeView.center = self.view.center
        view.addSubview(imgaeView)
        backButton = UIButton()
        
        view.addSubview(backButton)
        self.backButton.isSelected = true
        
        self.backButton.rx.isHidden.onnex
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(self.backButton.isSelected)
        self.backButton.isSelected = !self.backButton.isSelected
    }
}

extension Reactive where Base: UIButton {
    var isHidden: Binder<Bool> {
        return Binder(self.base) { button, hidden in
            button.isHidden = hidden
        }
    }
}
