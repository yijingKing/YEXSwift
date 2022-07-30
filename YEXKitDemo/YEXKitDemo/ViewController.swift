//
//  ViewController.swift
//  YEXKitDemo
//
//  Created by 祎 on 2022/7/30.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var image = UIImage(color: .red, size: .init(width: 100, height: 100))
        let imgaeView = UILabel(text: "sadasdasd", textColor: .red, font: nil)
        imgaeView.frame = CGRect.init(x: 0, y: 0, width: 100, height: 100)
        imgaeView.center = self.view.center
        view.addSubview(imgaeView)
    }
    


}

