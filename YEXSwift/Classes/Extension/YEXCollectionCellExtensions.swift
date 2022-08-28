//
//  YEXCollectionCell.swift
//  YEXSwift
//
//  Created by 祎 on 2022/8/27.
//

import Foundation
import UIKit

extension YEXProtocol where T: UICollectionViewCell {
    static var indentifier: String {
        return String(describing: Self.self)
    }
}
