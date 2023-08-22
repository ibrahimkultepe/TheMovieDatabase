//
//  MainHeaderView.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 17.08.2023.
//

public class MainHeaderView: UICollectionReusableView, ReusableView {
    
    private let collectionView = UICollectionViewBuilder()
        .backgroundColor(.clear)
        .scrollDirection(.horizontal)
        .build()
    
    private let pageControl = UIPageControlBuilder()
        .pageIndicatorTintColor(.appWhite.withAlphaComponent(0.2))
        .currentPageIndicatorTintColor(.appWhite)
        .isUserInteractionEnabled(false)
        .numberOfPages(5)
        .build()
    
    public var mainHeaderData: [MainCellModelProtocol] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        configureContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UILayout
extension MainHeaderView {
    
    private func addSubviews() {
        addSubview(collectionView)
        collectionView.edgesToSuperview()
        
        addSubview(pageControl)
        pageControl.bottomToSuperview()
        pageControl.centerXToSuperview()
    }
}

// MARK: - ConfigureContent
extension MainHeaderView {
    
    private func configureContent() {
        collectionView.register(MainHeaderCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }
}

// MARK: - UIScrollViewDelegate
extension MainHeaderView {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 2
        pageControl.currentPage = Int(offSet + horizontalCenter) / Int(width)
    }
}

// MARK: - UICollectionViewDataSource
extension MainHeaderView: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainHeaderData.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MainHeaderCell = collectionView.dequeueReusableCell(for: indexPath)
        let cellItem = mainHeaderData[indexPath.row]
        cell.setCellItem(viewModel: cellItem)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainHeaderView: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
