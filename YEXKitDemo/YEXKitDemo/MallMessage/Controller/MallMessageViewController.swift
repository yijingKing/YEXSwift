//
//  MallMessageViewController.swift
//  YEXKitDemo
//
//  Created by 祎 on 2022/8/12.
//

import UIKit
import YEXSwift

class MallMessageViewController: YEXBaseTableViewController {

    typealias DataSourceType = MallMessageModel
    
    lazy var viewModel: MallMessageViewModel = {
        return MallMessageViewModel()
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializeView()
        bindControlEvent()
        initializeViewData()
        
    }
    
    func initializeView() {
        
    }
}

// MARK: - 函数事件
extension MallMessageViewController {
    func bindControlEvent() {
        
    }
}

// MARK: - 数据处理
extension MallMessageViewController {
    func initializeViewData() {
        
    }
    
}

// MARK: - 通知
extension MallMessageViewController {
    
}

// MARK: - 代理
extension MallMessageViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        return UITableViewCell()
    }
}

