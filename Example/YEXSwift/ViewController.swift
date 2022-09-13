//
//  ViewController.swift
//  YEXSwift
//
//  Created by 1091676312@qq.com on 08/26/2022.
//  Copyright (c) 2022 1091676312@qq.com. All rights reserved.
//

import UIKit
import YEXSwift

class ViewController: YEXBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let nav = UINavigationController(rootViewController: SecendViewController())
        
        navigationController?.pushViewController(nav, animated: true)
    }
    
}
