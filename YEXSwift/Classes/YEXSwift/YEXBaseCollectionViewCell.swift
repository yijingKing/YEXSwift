//
//  YiBaseCollectionViewCell.swift
//  CXM
//
//  Created by 祎 on 2022/8/10.
//

import UIKit

open class YEXBaseCollectionViewCell: UICollectionViewCell {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func initializeView() {
        
    }
}
