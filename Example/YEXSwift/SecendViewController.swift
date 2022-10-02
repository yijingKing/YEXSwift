//
//  SecendViewController.swift
//  YEXSwift_Example
//
//  Created by 祎 on 2022/9/2.
//  Copyright © 2022 ╰莪呮想好好宠Nǐつ. All rights reserved.
//

import Foundation
import YEXSwift

class SecendViewController: YEXBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "二"
        view.backgroundColor = .red
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true)
    }
}


