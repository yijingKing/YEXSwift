//
//  BaseCollectionViewController.swift
//  CXM
//
//  Created by 祎 on 2022/8/10.
//

import UIKit
import RxSwift
import SnapKit

open class YEXBaseCollectionViewController: YEXBaseViewController {

    public typealias DataSourceType<T: Any> = T
    public var dataSource: [DataSourceType<Any>] = []
    
    public var dispaseBag = DisposeBag()
    
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
    
    public lazy var flowLayout: YEXEqualCellSpaceFlowLayout = {
        let layout = YEXEqualCellSpaceFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    public lazy var collectionView: YEXBaseCollectionView = {
        let collectionView = YEXBaseCollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.empty_title = "暂无数据"
        collectionView.empty_image = UIImage(named: "img_empty")
        collectionView.backgroundColor = .clear
        collectionView.empty_backgroundColor = .clear
        collectionView.keyboardDismissMode = .onDrag
        return collectionView
    }()
    
    public override func viewDidLoad() {
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
        registerCollectionCell(withClass: UICollectionViewCell.self)
    }
    
}

public extension YEXBaseCollectionViewController {
    ///注册CollectionView cell
    func registerCollectionCell(withClass cell:AnyClass) {
        mainCollection?.register(cell, forCellWithReuseIdentifier: NSStringFromClass(cell))
    }
    
    func registerCollectionCell(withClass cell:AnyClass,cellName:String) {
        mainCollection?.register(cell, forCellWithReuseIdentifier: cellName)
    }
    ///注册CollectionView cell
    func registerCollectionCell(withClass cells:[AnyClass]) {
        for index in 0..<cells.count {
            mainCollection?.register(cells[index], forCellWithReuseIdentifier: NSStringFromClass(cells[index]))
        }
    }
    ///注册CollectionView nib cell
    func registerCollectionCell(withClass cellNib:String,cellNameNib:String) {
        mainCollection?.register(UINib.init(nibName: cellNib, bundle: nil), forCellWithReuseIdentifier: cellNameNib)
    }
    ///注册CollectionView nib cell
    func registerCollectionCell(withClass cellNibs:[String],cellNibName:[String]) {
        for index in 0 ..< cellNibs.count {
            mainCollection?.register(UINib.init(nibName: cellNibs[index], bundle: nil), forCellWithReuseIdentifier: cellNibName[index])
        }
    }
}

// MARK: - 函数事件
public extension YEXBaseCollectionViewController {
    private func normalEmpty() {
        collectionView.empty_title = "暂无数据"
        collectionView.empty_btn_title = nil
    }
    
    private func notDataEmpty() {
        collectionView.empty_title = nil
        collectionView.empty_button(title: "重新加载") { [weak self] in
            self?.refreshData()
        }
    }
    
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
       ///监听网络为无网络状态时
       NoNetworkSubject.subscribe(onNext: { [weak self] isNot in
           self?.emptyType = isNot ? EmptyType.noNetWork : EmptyType.normal
       }).disposed(by: dispaseBag)
       
   }
}

// MARK: - 刷新
@objc extension YEXBaseCollectionViewController {
    ///下拉
    private func refreshHeaderAction() {
        self.collectionView.mj_footer?.isHidden = false
        self.collectionView.isLoading = true
        refreshData()
    }
    ///下拉(用于子类请求数据)
    open func refreshData() {
        
    }
    ///上拉
    private func refreshFootAction() {
        self.collectionView.mj_footer?.isHidden = false
        self.collectionView.isLoading = true
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
    
    ///刷新并判断是否是最后一页,是最后一页显示最后一页的数据(当前页   总页数)
    func reloadDataOrMore(now: Int, total: Int) {
        self.page = now
        self.totalPage = total
        reloadDataAndEndRefreshing()
    }
    
    ///刷新并判断是否是最后一页,是最后一页显示最后一页的数据(当前页   总页数)
    func reloadDataOrNotMore() {
        reloadDataOrMore(now: 0, total: 0)
    }
    private func reloadDataAndEndRefreshing() {
        self.collectionView.isLoading = false
        self.collectionView.reloadEmptyDataSet()
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
        
        guard self.dataSource.count > 0 else { return 0 }
        
        return 1
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.indentifier, for: indexPath)
    }
    
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}




extension UICollectionViewCell {
    static var indentifier: String {
        return NSStringFromClass(self)
    }
}



enum AlignType  {
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
