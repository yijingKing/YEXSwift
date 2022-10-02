//
//  ViewController.swift
//  YEXSwift
//
//  Created by 1091676312@qq.com on 08/26/2022.
//  Copyright (c) 2022 1091676312@qq.com. All rights reserved.
//

import UIKit
import YEXSwift


struct Model: Codable {
    var s: String
    
    enum CodingKeys: CodingKey {
        case s
    }
    init(s: String) {
        self.s = s
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.s = try container.decode(String.self, forKey: .s)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.s, forKey: .s)
    }
}

class ViewController: YEXBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        navigationController?.pushViewController(SecendViewController(), animated: true)
    }
    
}
