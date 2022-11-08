/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/yijingKing
********************************************************************************/

import UIKit

public extension UITableView {

    ///使用完成处理程序重新加载数据
    func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }

    /// 移除 TableFooterView.
    func removeTableFooterView() {
        self.tableFooterView = nil
    }

    /// 移除 TableHeaderView.
    func removeTableHeaderView() {
        self.tableHeaderView = nil
    }
    /// 根据类名获取重用池中的单元格
    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: String(describing: name)) as? T else {
            fatalError("Couldn't find UITableViewCell for \(String(describing: name)), make sure the cell is registered with table view")
        }
        return cell
    }
    /// 根据类名获取重用池中的单元格
    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError("Couldn't find UITableViewCell for \(String(describing: name)), make sure the cell is registered with table view")
        }
        return cell
    }

    /// 根据类名获取重用池中的区视图
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withClass name: T.Type) -> T {
        guard let headerFooterView = self.dequeueReusableHeaderFooterView(withIdentifier: String(describing: name)) as? T else {
            fatalError("Couldn't find UITableViewHeaderFooterView for \(String(describing: name)), make sure the view is registered with table view")
        }
        return headerFooterView
    }

    /// 根据类名注册重用池中的区视图
    func register<T: UITableViewHeaderFooterView>(nib: UINib?, withHeaderFooterViewClass name: T.Type) {
        self.register(nib, forHeaderFooterViewReuseIdentifier: String(describing: name))
    }

    /// 根据类名注册重用池中的区视图
    func register<T: UITableViewHeaderFooterView>(headerFooterViewClassWith name: T.Type) {
        self.register(T.self, forHeaderFooterViewReuseIdentifier: String(describing: name))
    }

    /// 根据类名注册重用池中的cell
    func register<T: UITableViewCell>(cellWithClass name: T.Type) {
        self.register(T.self, forCellReuseIdentifier: String(describing: name))
    }

    /// 根据类名注册重用池中的cell
    func register<T: UITableViewCell>(nib: UINib?, withCellClass name: T.Type) {
        self.register(nib, forCellReuseIdentifier: String(describing: name))
    }

    /// 检测indexpath是否有效
    func isValidIndexPath(_ indexPath: IndexPath) -> Bool {
        return indexPath.section >= 0 &&
            indexPath.row >= 0 &&
        indexPath.section < self.numberOfSections &&
        indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }

    /// 滚动到对应cell(防止越界)
    func safeScrollToRow(at indexPath: IndexPath, at scrollPosition: UITableView.ScrollPosition, animated: Bool) {
        guard indexPath.section < self.numberOfSections else { return }
        guard indexPath.row < self.numberOfRows(inSection: indexPath.section) else { return }
        self.scrollToRow(at: indexPath, at: scrollPosition, animated: animated)
    }

}

