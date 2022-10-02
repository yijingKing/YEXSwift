/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/yijingKing
********************************************************************************/


import Foundation
import UIKit
import MJRefresh

protocol BaseViewProtocol {
    typealias DataSourceType<T: Any> = T
}


open class YEXBaseTableViewController: YEXBaseViewController,BaseViewProtocol {
    private var isLoading  : Bool = true
    ///数据的类型
    public typealias DataSourceType<T: Any> = T
    ///数据数组(默认使用二维)
    public var dataSource: [DataSourceType<Any>] = []
    ///设置tableView方式(viewDidLoad前调用)
    public var style: UITableView.Style = .grouped
    ///隐藏刷新
    public var hiddenHeaderRefresh = false
    ///隐藏加载
    public var hiddenFooterRefresh = false
    ///自定义刷新(需先影藏默认设置)
    public var headerRefresh: MJRefreshHeader? {
        didSet {
            self.tableView.mj_header = headerRefresh
        }
    }
    ///自定义加载(需先影藏默认设置)
    public var footerRefresh: MJRefreshFooter? {
        didSet {
            self.tableView.mj_footer = footerRefresh
        }
    }
    ///当前页数
    public var page: Int = 1
    ///总共页数
    public var totalPage: Int = 1
    ///懒加载
    public lazy var tableView: YEXBaseTableView = {
        let tableView = YEXBaseTableView(frame: .zero, style: self.style)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = UIColor.clear
        tableView.estimatedRowHeight = 44
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.tableFooterView = UIView().yex.then {
            $0.frame = .init(x: 0, y: 0, width: ScreenWidth, height: SafeDistanceBottom)
            $0.backgroundColor = UIColor.clear
        }
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        base_initializeView()
        base_bindControlEvent()
    }

    private func base_initializeView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    ///结束刷新状态
    public func endRefreshing() {
        tableView.mj_header?.endRefreshing()
        tableView.mj_footer?.endRefreshing()
    }
}

// MARK: - 函数事件
extension YEXBaseTableViewController {
    func base_bindControlEvent() {
        if !hiddenHeaderRefresh {
            self.tableView.refreshNormakHeader { [weak self] in
                self?.refreshHeaderAction()
            }
        }
        if !hiddenFooterRefresh {
            self.tableView.refreshFooter { [weak self] in
                self?.refreshFootAction()
            }
        }
    }
}

// MARK: - 刷新
@objc extension YEXBaseTableViewController {
    ///下拉(用于子类请求数据)
    open func refreshData() {
        
    }
    ///上拉(用于子类请求数据)
    open func getMoreData() {
        
    }
}

public extension YEXBaseTableViewController {
    ///刷新并判断是否是最后一页,是最后一页显示最后一页的数据(当前页   总页数)
    func reloadDataOrMore(now: Int? = 0, total: Int? = 0) {
        self.page = now ?? 0
        self.totalPage = total ?? 0
        reloadDataAndEndRefreshing()
    }
    ///刷新并判断是否是最后一页,是最后一页显示最后一页的数据(当前页   总页数)
    func reloadDataOrNotMore() {
        self.page = 1
        self.totalPage = 1
        reloadDataAndEndRefreshing()
    }
    ///下拉
    private func refreshHeaderAction() {
        self.tableView.mj_footer?.isHidden = false
        self.isLoading = true
        refreshData()
    }
    ///上拉
    private func refreshFootAction() {
        self.tableView.mj_footer?.isHidden = false
        self.isLoading = true
        getMoreData()
    }
    
    private func reloadDataAndEndRefreshing() {
        self.isLoading = false
        self.tableView.mj_header?.endRefreshing()
        self.tableView.reloadData()
        if let _ = self.tableView.mj_footer {
            self.tableView.mj_footer?.endRefreshing()
            if page >= totalPage {
                if page == 1 {
                    self.tableView.mj_footer?.isHidden = true
                } else {
                    self.tableView.mj_footer?.isHidden = false
                }
                self.tableView.endRefreshingWithNoMoreData()
            }
        }
    }
}

// MARK: - tableView delegate
@objc extension YEXBaseTableViewController: UITableViewDelegate,UITableViewDataSource {
    open func numberOfSections(in tableView: UITableView) -> Int {
        guard dataSource.count > 0 else { return 0 }
        if dataSource.first is Array<Any> {
            return dataSource.count
        }
        return 1
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard dataSource.count > 0 else { return 0 }
        
        if dataSource[section] is Array<Any> {
            if let data = dataSource[section] as? Array<Any> {
                return data.count
            } else {
                return 0
            }
        }
        return dataSource.count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
