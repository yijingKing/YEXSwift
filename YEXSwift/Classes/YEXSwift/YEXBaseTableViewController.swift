//
//  BaseTableViewController.swift
//  CXM
//
//  Created by 祎 on 2022/8/2.
//

import Foundation
import UIKit
import RxSwift

public enum EmptyType {
    case normal
    case noNetWork
}
protocol BaseViewProtocol {
    typealias DataSourceType<T: Any> = T
}

public let NoNetworkSubject = ReplaySubject<Bool>.create(bufferSize: 0)

open class YEXBaseTableViewController: YEXBaseViewController,BaseViewProtocol {
    public typealias DataSourceType<T: Any> = T
    public var dataSource: [DataSourceType<Any>] = []
    
    public var dispaseBag = DisposeBag()
    ///设置tableView方式(viewDidLoad前调用)
    public var style: UITableView.Style = .plain
    public var hiddenHeaderRefresh = false
    public var hiddenFooterRefresh = false
    ///当前页数
    public var page: Int = 1
    ///总共页数
    public var totalPage: Int = 1
    ///空界面类型
    public var emptyType: EmptyType? = .normal {
        didSet {
            if emptyType == .normal {
                self.normalEmpty()
            } else if emptyType == .noNetWork {
                self.notDataEmpty()
            }
        }
    }
    ///懒加载
    public lazy var tableView: YEXBaseTableView = {
        let tableView = YEXBaseTableView(frame: .zero, style: self.style)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = UIColor.clear
        tableView.empty_backgroundColor = UIColor.clear
        tableView.estimatedRowHeight = 44
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.tableFooterView = UIView().yex.then {
            $0.frame = .init(x: 0, y: 0, width: YEXScreenWidth, height: YEXBottomHeight)
            $0.backgroundColor = UIColor.clear
        }
        tableView.keyboardDismissMode = .onDrag
        tableView.empty_title = "暂无数据"
        tableView.empty_image = UIImage(named: "img_empty")
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
            $0.left.right.bottom.equalTo(0)
            $0.top.equalTo(view.snp.topMargin)
        }
    }
    
    public func normalEmpty() {
        tableView.empty_title = "暂无数据"
        tableView.empty_btn_title = nil
    }
    
    public func notDataEmpty() {
        tableView.empty_title = nil
        tableView.empty_button(title: "重新加载") { [weak self] in
            self?.refreshData()
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
        ///监听网络为无网络状态时
        NoNetworkSubject.subscribe(onNext: { [weak self] isNot in
            self?.emptyType = isNot ? EmptyType.noNetWork : EmptyType.normal
        }).disposed(by: dispaseBag)
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
        self.tableView.isLoading = false
        reloadDataAndEndRefreshing()
    }
    ///刷新并判断是否是最后一页,是最后一页显示最后一页的数据(当前页   总页数)
    func reloadDataOrNotMore() {
        self.page = 1
        self.totalPage = 1
        self.tableView.isLoading = false
        reloadDataAndEndRefreshing()
    }
    
    ///下拉
    private func refreshHeaderAction() {
        self.tableView.mj_footer?.isHidden = false
        refreshData()
    }
    ///上拉
    private func refreshFootAction() {
        self.tableView.mj_footer?.isHidden = false
        getMoreData()
    }
    
    private func reloadDataAndEndRefreshing() {
        self.tableView.isLoading = true
        self.tableView.reloadEmptyDataSet()
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
        return dataSource.count
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard dataSource.count > 0 else { return 0 }
        if dataSource[section] is Array<Any> {
            return (dataSource[section] as? Array<Any>)?.count ?? 0
        }
        return 1
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
