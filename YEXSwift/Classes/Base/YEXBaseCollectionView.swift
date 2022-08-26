/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/yijingKing
********************************************************************************/


import UIKit
import MJRefresh
import DZNEmptyDataSet
import SnapKit

open class YEXBaseCollectionView: UICollectionView {
    var isLoading               : Bool = true
    private var _empty_image           : UIImage?
    private var _empty_btn_image       : UIImage?
    private var emptyClickBlock         : (() -> Void)? = nil
    
    var empty_title             : String?   = "暂无数据"
    var empty_titleFont         : UIFont    = UIFont.systemFont(ofSize: 15)
    var empty_titleColor        : UIColor   = .black
    
    var empty_description       : String?
    var empty_descriptionFont   : UIFont    = UIFont.systemFont(ofSize: 15)
    var empty_descriptionColor  : UIColor   = .black
    var empty_image             : UIImage? {
        set {
            _empty_image = newValue
            reloadCollectionView()
        }
        get {
            return _empty_image
        }
    }
    
    var empty_btn_title         : String?
    var empty_btn_titleFont     : UIFont    = UIFont.systemFont(ofSize: 15)
    var empty_btn_titleColor    : UIColor   = .black
    var empty_btn_image         : UIImage? {
        set {
            _empty_btn_image = newValue
            reloadCollectionView()
        }
        get {
            return _empty_btn_image
        }
    }
    ///图文间距
    var empty_spaceHeight       : CGFloat   = YEXRatio(10)
    ///偏移
    var empty_verticalOffset    : CGFloat   = 0
    var empty_backgroundColor   : UIColor   = .black
    var isscrollEnabled         : Bool?
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        if #available(iOS 11.0, *) {
            if #available(iOS 13.0, *) {
                automaticallyAdjustsScrollIndicatorInsets = false
            }
            contentInsetAdjustmentBehavior = .never
        } else {
            
        }
        emptyDataSetSource = self
        emptyDataSetDelegate = self
        _empty_btn_image = UIImage(color: .lightGray, size: .init(width: 100, height: 40))
    }
    open override func reloadData() {
        super.reloadData()
        
        if let enabled = isscrollEnabled {
            isScrollEnabled = enabled
        }
    }
    open override func reloadEmptyDataSet() {
        super.reloadEmptyDataSet()
    }
    fileprivate func reloadCollectionView(){
        reloadEmptyDataSet()
        reloadData()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func empty_button(title: String,_ bl: (() -> Void)?) {
        self.isLoading = false
        empty_title = nil
        empty_btn_title = title
        emptyClickBlock = bl
        reloadCollectionView()
    }
}

//MARK: --- DZNEmptyDataSet  空界面
extension YEXBaseCollectionView: DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {

    //MARK: -- DZNEmptyDataSetSource Methods
    ///标题为空的数据集
    public func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let attributes = [NSAttributedString.Key.font: empty_titleFont,
                          NSAttributedString.Key.foregroundColor: empty_titleColor]
        if isLoading {
            return nil
        }
        if let tit = empty_title {
            return NSAttributedString(string: tit, attributes: attributes)
        }
        
        return  nil
    }
    ///描述
    public func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        if isLoading {
            return nil
        }
       let paragraph = NSMutableParagraphStyle()
       paragraph.alignment = .center
       paragraph.lineSpacing = CGFloat(NSLineBreakMode.byWordWrapping.rawValue)
        let attributes = [NSAttributedString.Key.font: empty_descriptionFont,
                          NSAttributedString.Key.foregroundColor: empty_descriptionColor,
                          NSAttributedString.Key.paragraphStyle: paragraph]
        if let des = empty_description {
            return NSAttributedString(string: des, attributes: attributes)
        }
        return nil
    }
    ///图片
    public func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        if isLoading {
            return nil
        }
        if let img = empty_image {
            return img
        }
        return nil
    }
    ///数据集加载动画
    public func imageAnimation(forEmptyDataSet scrollView: UIScrollView!) -> CAAnimation! {
       let animation = CABasicAnimation(keyPath: "transform")
       animation.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
       animation.toValue = NSValue(caTransform3D: CATransform3DMakeRotation(CGFloat(Double.pi / 2), 0.0, 0.0, 1.0))
       animation.duration = 0.25
       animation.isCumulative = true
       animation.repeatCount = MAXFLOAT
       return animation as CAAnimation
    }
    ///按钮标题
    public func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> NSAttributedString! {
        if isLoading {
            return nil
        }
        let attributes = [NSAttributedString.Key.font: empty_btn_titleFont,
                          NSAttributedString.Key.foregroundColor: empty_btn_titleColor]
        
        if let tit = empty_btn_title {
            return NSAttributedString(string: tit, attributes: attributes)
        }
        return nil
    }

    ///重新加载按钮背景图片
    public func buttonBackgroundImage(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> UIImage! {
        if isLoading {
            return nil
        }
        if let empty_image = empty_image {
            return empty_image
        }
        return nil
       
    }
    ///自定义背景颜色
    public func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return empty_backgroundColor
    }

    public func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return empty_verticalOffset
    }

    public func spaceHeight(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return empty_spaceHeight
    }

    //MARK: -- DZNEmptyDataSetDelegate
    ///数据源为空时是否渲染和显示 (默认为 YES)
    public func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
       return true
    }
    ///是否允许点击 (默认为 YES)
    public func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView!) -> Bool {
       return true
    }
    ///是否允许滚动(默认为 NO)
    public func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
       return false
    }

    ///是否允许动画(默认为 NO)
    public func emptyDataSetShouldAnimateImageView(_ scrollView: UIScrollView!) -> Bool {
       return false
    }
    ///视图触发
    public func emptyDataSet(_ scrollView: UIScrollView!, didTap view: UIView!) {
        
        if let block = emptyClickBlock {
            block()
        }
    }
    ///按钮触发
    public func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        if let block = emptyClickBlock {
            block()
        }
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
