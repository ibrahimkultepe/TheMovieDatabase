//
//  HomeHeaderView.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 17.08.2023.
//

public class HomeHeaderView: UICollectionReusableView, ReusableView {
    
    private let collectionView = UICollectionViewBuilder()
        .backgroundColor(.clear)
        .scrollDirection(.horizontal)
        .build()
    
    private let pageControl = UIPageControlBuilder()
        .pageIndicatorTintColor(.appWhite.withAlphaComponent(0.2))
        .currentPageIndicatorTintColor(.appWhite)
        .isUserInteractionEnabled(false)
        .build()
    
    public var homeHeaderData: [HomeHeaderCellModelProtocol] = [] {
        didSet {
            collectionView.reloadData()
            pageControl.numberOfPages = homeHeaderData.count
        }
    }
    
    public var didSelectItemAtHomeHeaderView: IntClosure?
    
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
extension HomeHeaderView {
    
    private func addSubviews() {
        addSubview(collectionView)
        collectionView.edgesToSuperview()
        
        addSubview(pageControl)
        pageControl.bottomToSuperview()
        pageControl.centerXToSuperview()
    }
}

// MARK: - ConfigureContent
extension HomeHeaderView {
    
    private func configureContent() {
        collectionView.register(HomeHeaderCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }
}

// MARK: - UIScrollViewDelegate
extension HomeHeaderView {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 2
        pageControl.currentPage = Int(offSet + horizontalCenter) / Int(width)
    }
}

// MARK: - UICollectionViewDataSource
extension HomeHeaderView: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieId = homeHeaderData[indexPath.row].movieId
        didSelectItemAtHomeHeaderView?(movieId)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeHeaderData.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeHeaderCell = collectionView.dequeueReusableCell(for: indexPath)
        let cellItem = homeHeaderData[indexPath.row]
        cell.setCellItem(viewModel: cellItem)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeHeaderView: UICollectionViewDelegateFlowLayout {
    
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
