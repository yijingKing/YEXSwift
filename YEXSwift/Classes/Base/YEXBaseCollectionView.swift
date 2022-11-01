/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/yijingKing
********************************************************************************/


import UIKit
import MJRefresh
import SnapKit

open class YEXBaseCollectionView: UICollectionView {
    
    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        if #available(iOS 11.0, *) {
            if #available(iOS 13.0, *) {
                automaticallyAdjustsScrollIndicatorInsets = false
            }
            contentInsetAdjustmentBehavior = .never
        }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

public extension UICollectionView {
    ///下拉
    func refreshNormakHeader (_ refreshingBlock: @escaping () -> Void) {
        
        let header = MJRefreshNormalHeader.init(refreshingBlock: refreshingBlock)
        mj_header = header
    }
    
    ///动画下拉
    func refreshGifHeader (_ refreshingBlock: @escaping () -> Void) {
        let header = MJRefreshGifHeader.init(refreshingBlock: refreshingBlock)
        mj_header = header
    }
    
    ///上拉
    func refreshFooter (_ refreshingBlock: @escaping () -> Void) {
        let footer = MJRefreshBackNormalFooter.init(refreshingBlock: refreshingBlock)
        mj_footer = footer
    }
    
    ///提示没有更多的数据
    func endRefreshingWithNoMoreData(){
        mj_footer?.endRefreshingWithNoMoreData()
    }
    
    ///结束刷新状态
    func endRefreshing() {
        mj_header?.endRefreshing()
        mj_footer?.endRefreshing()
    }
}
