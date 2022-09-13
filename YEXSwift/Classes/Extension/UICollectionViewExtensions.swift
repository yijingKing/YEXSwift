/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/yijingKing
********************************************************************************/

import UIKit

public extension YEXProtocol where T: UICollectionView {

    ///使用完成处理程序重新加载数据
    func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            obj.reloadData()
        }, completion: { _ in
            completion()
        })
    }
    /// 根据类名获取重用池中的cell
    func dequeueReusableCell<T: UICollectionViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = obj.dequeueReusableCell(withReuseIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError("Couldn't find UICollectionViewCell for \(String(describing: name)), make sure the cell is registered with collection view")
        }
        return cell
    }
    /// 根据类名获取重用池中的区头视图
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind: String, withClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = obj.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError("Couldn't find UICollectionReusableView for \(String(describing: name)), make sure the view is registered with collection view")
        }
        return cell
    }
    /// 根据类名注册重用池中的cell
    func register<T: UICollectionReusableView>(supplementaryViewOfKind kind: String, withClass name: T.Type) {
        obj.register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: name))
    }
    /// 根据类名注册重用池中的cell
    func register<T: UICollectionViewCell>(nib: UINib?, forCellWithClass name: T.Type) {
        obj.register(nib, forCellWithReuseIdentifier: String(describing: name))
    }
    /// 根据类名注册重用池中的cell
    func register<T: UICollectionViewCell>(cellWithClass name: T.Type) {
        obj.register(T.self, forCellWithReuseIdentifier: String(describing: name))
    }
    /// 根据类名获取重用池中的区头视图
    func register<T: UICollectionReusableView>(nib: UINib?, forSupplementaryViewOfKind kind: String, withClass name: T.Type) {
        obj.register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: name))
    }

    /// 滚动到对应item(防止越界)
    func safeScrollToItem(at indexPath: IndexPath, at scrollPosition: UICollectionView.ScrollPosition, animated: Bool) {
        guard indexPath.item >= 0 &&
            indexPath.section >= 0 &&
                indexPath.section < obj.numberOfSections &&
                indexPath.item < obj.numberOfItems(inSection: indexPath.section) else {
                return
        }
        obj.scrollToItem(at: indexPath, at: scrollPosition, animated: animated)
    }

    /// 检测indexpath是否有效
    func isValidIndexPath(_ indexPath: IndexPath) -> Bool {
        return indexPath.section >= 0 &&
            indexPath.item >= 0 &&
        indexPath.section < obj.numberOfSections &&
        indexPath.item < obj.numberOfItems(inSection: indexPath.section)
    }

}

