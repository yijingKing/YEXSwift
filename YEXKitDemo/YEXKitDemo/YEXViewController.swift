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
        let imgaeView = UILabel(text: "", textColor: .red, font: nil)
        imgaeView.frame = CGRect.init(x: 0, y: 0, width: 300, height: 100)
        imgaeView.center = self.view.center
        view.addSubview(imgaeView)
        backButton = UIButton()
        
        view.addSubview(backButton)
        self.backButton.isSelected = true
        
        imgaeView.attributedText = "思远沙雕".yex.setOutline(font: .systemFont(ofSize: 25), alignment: .center, textColor: .blue, strokeWidth: -4, widthColor: .red)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        present(MallMessageViewController(), animated: true)
        
    }
    
    /// 给字体添加描边效果 : strokeWidth为正数为空心文字描边 strokeWidth为负数为实心文字描边
    private func drawOutlineAttributedString (
        string: String,
        fontSize: CGFloat,
        alignment: NSTextAlignment,
        textColor: UIColor,
        strokeWidth: CGFloat,
        widthColor: UIColor) -> NSAttributedString {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = alignment
        paragraph.lineHeightMultiple = 0.93
        let dic: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize),
            NSAttributedString.Key.paragraphStyle: paragraph,
            NSAttributedString.Key.foregroundColor: textColor,
            NSAttributedString.Key.strokeWidth: strokeWidth,
            NSAttributedString.Key.strokeColor: widthColor,
            NSAttributedString.Key.kern: 1
        ]
        var attributedText: NSMutableAttributedString!
        attributedText = NSMutableAttributedString(string: string, attributes: dic)
        return attributedText
    }
    
}

extension Reactive where Base: UIButton {
    var isHidden: Binder<Bool> {
        return Binder(self.base) { button, hidden in
            button.isHidden = hidden
        }
    }
}
