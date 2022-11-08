/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/yijingKing
********************************************************************************/


import UIKit
import RxSwift
import SnapKit
import MJRefresh

open class YEXBaseCollectionViewController: YEXBaseViewController {
    private var isLoading  : Bool = true
    ///数据的类型
    public typealias DataSourceType<T: Any> = T
    ///数据数组(默认使用二维)
    public var dataSource: [DataSourceType<Any>] = []
    public var dispaseBag = DisposeBag()
    ///隐藏刷新
    public var hiddenHeaderRefresh = false
    ///隐藏加载
    public var hiddenFooterRefresh = false
    ///自定义刷新(需先影藏默认设置)
    public var headerRefresh: MJRefreshHeader? {
        didSet {
            self.collectionView.mj_header = headerRefresh
        }
    }
    ///自定义加载(需先影藏默认设置)
    public var footerRefresh: MJRefreshFooter? {
        didSet {
            self.collectionView.mj_footer = footerRefresh
        }
    }
    ///当前页数
    public var page: Int = 1
    ///总共页数
    public var totalPage: Int = 1
    ///自定义flowLayout(初始化前设置)
    public var flowLayout: UICollectionViewFlowLayout?
    
    public lazy var collectionView: YEXBaseCollectionView = {
        
        let layout = self.flowLayout ?? UICollectionViewFlowLayout()
        
        let collectionView = YEXBaseCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.keyboardDismissMode = .onDrag
        return collectionView
    }()
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        base_initializeView()
        base_bindControlEvent()
        
    }
    
    func base_initializeView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.left.right.bottom.equalTo(0)
            $0.top.equalTo(view.snp.topMargin)
        }
        collectionView.register(cellWithClass: UICollectionViewCell.self)
    }
    
}

// MARK: - 函数事件
public extension YEXBaseCollectionViewController {
    
    private func base_bindControlEvent() {
       if !hiddenHeaderRefresh {
           self.collectionView.refreshNormakHeader { [weak self] in
               self?.refreshHeaderAction()
           }
       }
       if !hiddenFooterRefresh {
           self.collectionView.refreshFooter { [weak self] in
               self?.refreshFootAction()
           }
       }
   }
}

// MARK: - 刷新
@objc extension YEXBaseCollectionViewController {
    ///下拉
    private func refreshHeaderAction() {
        self.collectionView.mj_footer?.isHidden = false
        self.isLoading = true
        refreshData()
    }
    ///下拉(用于子类请求数据)
    open func refreshData() {
        
    }
    ///上拉
    private func refreshFootAction() {
        self.collectionView.mj_footer?.isHidden = false
        self.isLoading = true
        getMoreData()
    }
    ///上拉(用于子类请求数据)
    open func getMoreData() {
        
    }
    ///结束刷新状态
    func endRefreshing() {
        collectionView.mj_header?.endRefreshing()
        collectionView.mj_footer?.endRefreshing()
    }
    
    ///刷新并判断是否是最后一页,是最后一页显示无更多数据(当前页   总页数)
    func reloadDataOrMore(now: Int, total: Int) {
        self.page = now
        self.totalPage = total
        reloadDataAndEndRefreshing()
    }
    
    ///刷新并显示无更多数据(当前页   总页数)
    func reloadDataOrNotMore() {
        reloadDataOrMore(now: 0, total: 0)
    }
    private func reloadDataAndEndRefreshing() {
        self.isLoading = false
        self.collectionView.mj_header?.endRefreshing()
        self.collectionView.reloadData()
        if let _ = self.collectionView.mj_footer {
            self.collectionView.mj_footer?.endRefreshing()
            if page >= totalPage {
                if page == 1 {
                    self.collectionView.mj_footer?.isHidden = true
                } else {
                    self.collectionView.mj_footer?.isHidden = false
                }
                self.collectionView.endRefreshingWithNoMoreData()
            }
        }
    }
}
// MARK: - 代理
extension YEXBaseCollectionViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard dataSource.count > 0 else { return 0 }
        if dataSource.first is Array<Any> {
            return dataSource.count
        }
        return 1
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withClass: UICollectionViewCell.self, for: indexPath)
    }
    
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}


public enum AlignType  {
    case left
    case center
    case right
}

public class YEXEqualCellSpaceFlowLayout: UICollectionViewFlowLayout {
    
    //两个Cell之间的距离
    var betweenOfCell : CGFloat{
        didSet{
            self.minimumInteritemSpacing = betweenOfCell
        }
    }
    
    //cell对齐方式
    var cellType : AlignType = AlignType.center
    
    //在居中对齐的时候需要知道这行所有cell的宽度总和
    var sumCellWidth : CGFloat = 0.0
    
    override init() {
        betweenOfCell = 0
        super.init()
    }
    
    convenience init(_ cellType:AlignType){
        self.init()
        self.cellType = cellType
    }
    
    convenience init(_ cellType: AlignType, _ betweenOfCell: CGFloat){
        self.init()
        self.cellType = cellType
        self.betweenOfCell = betweenOfCell
    }
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let layoutAttributes_super : [UICollectionViewLayoutAttributes] = super.layoutAttributesForElements(in: rect) ?? [UICollectionViewLayoutAttributes]()
        let layoutAttributes:[UICollectionViewLayoutAttributes] = NSArray(array: layoutAttributes_super, copyItems:true)as! [UICollectionViewLayoutAttributes]
        var layoutAttributes_t : [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
        for index in 0..<layoutAttributes.count{
            
            let currentAttr = layoutAttributes[index]
            let previousAttr = index == 0 ? nil : layoutAttributes[index-1]
            let nextAttr = index + 1 == layoutAttributes.count ?
                nil : layoutAttributes[index+1]
            
            layoutAttributes_t.append(currentAttr)
            sumCellWidth += currentAttr.frame.size.width
            
            let previousY :CGFloat = previousAttr == nil ? 0 : previousAttr!.frame.maxY
            let currentY :CGFloat = currentAttr.frame.maxY
            let nextY:CGFloat = nextAttr == nil ? 0 : nextAttr!.frame.maxY
            
            if currentY != previousY && currentY != nextY {
                if currentAttr.representedElementKind == UICollectionView.elementKindSectionHeader {
                    layoutAttributes_t.removeAll()
                    sumCellWidth = 0.0
                } else if currentAttr.representedElementKind == UICollectionView.elementKindSectionFooter {
                    layoutAttributes_t.removeAll()
                    sumCellWidth = 0.0
                } else {
                    self.setCellFrame(with: layoutAttributes_t)
                    layoutAttributes_t.removeAll()
                    sumCellWidth = 0.0
                }
            } else if currentY != nextY {
                self.setCellFrame(with: layoutAttributes_t)
                layoutAttributes_t.removeAll()
                sumCellWidth = 0.0
            }
        }
        return layoutAttributes
    }
    
    /// 调整Cell的Frame
    ///
    /// - Parameter layoutAttributes: layoutAttribute 数组
    func setCellFrame(with layoutAttributes : [UICollectionViewLayoutAttributes]){
        var nowWidth : CGFloat = 0.0
        switch cellType {
        case AlignType.left:
            nowWidth = self.sectionInset.left
            for attributes in layoutAttributes{
                var nowFrame = attributes.frame
                nowFrame.origin.x = nowWidth
                attributes.frame = nowFrame
                nowWidth += nowFrame.size.width + self.minimumLineSpacing
            }
        case AlignType.center:
            nowWidth = (self.collectionView!.frame.size.width - sumCellWidth - (CGFloat(layoutAttributes.count - 1) * minimumLineSpacing)) / 2
            for attributes in layoutAttributes{
                var nowFrame = attributes.frame
                nowFrame.origin.x = nowWidth
                attributes.frame = nowFrame
                nowWidth += nowFrame.size.width + self.minimumLineSpacing
            }
        case AlignType.right:
            nowWidth = self.collectionView!.frame.size.width - self.sectionInset.right
            for var index in 0 ..< layoutAttributes.count{
                index = layoutAttributes.count - 1 - index
                let attributes = layoutAttributes[index]
                var nowFrame = attributes.frame
                nowFrame.origin.x = nowWidth - nowFrame.size.width
                attributes.frame = nowFrame
                nowWidth = nowWidth - nowFrame.size.width - minimumLineSpacing
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
