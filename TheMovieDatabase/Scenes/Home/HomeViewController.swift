//
//  HomeViewController.swift
//  TheMovieDatabase
//
//  Created by İbrahim Kültepe on 15.08.2023.
//

final class HomeViewController: BaseViewController<HomeViewModel> {
    
    private let refreshControl = UIRefreshControl()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundImage = UIImage()
        return searchBar
    }()
    
    private let collectionView = UICollectionViewBuilder()
        .backgroundColor(.clear)
        .scrollDirection(.vertical)
        .build()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureContent()
        subcribeViewModel()
        viewModel.getData(showLoading: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

// MARK: - UILayout
extension HomeViewController {
    
    private func addSubviews() {
        view.addSubview(searchBar)
        searchBar.edgesToSuperview(excluding: .bottom, insets: .init(top: 0, left: 15, bottom: 0, right: 15), usingSafeArea: true)
        
        view.addSubview(collectionView)
        collectionView.topToBottom(of: searchBar).constant = 5
        collectionView.edgesToSuperview(excluding: .top)
    }
}

// MARK: - ConfigureContent
extension HomeViewController {
    
    private func configureContent() {
        collectionView.register(HomeMovieCell.self)
        collectionView.registerHeader(HomeHeaderView.self)
        collectionView.registerFooter(ActivityIndicatorViewFooterView.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
}

// MARK: - Actions
extension HomeViewController {
    
    @objc
    private func refreshData() {
        viewModel.refreshData()
    }
}

// MARK: - UIScrollViewDelegate
extension HomeViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let viewHeight = scrollView.frame.height
        
        if contentOffsetY > (contentHeight - viewHeight) && viewModel.isPagingEnabled && !viewModel.isRequestEnabled {
            viewModel.getUpcomingMovies()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeMovieCell = collectionView.dequeueReusableCell(for: indexPath)
        let cellItem = viewModel.cellItemForAt(indexPath: indexPath)
        cell.setCellItem(viewModel: cellItem)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header: HomeHeaderView = collectionView.dequeueReusableCell(ofKind: kind, for: indexPath)
            header.homeHeaderData = viewModel.homeHeaderCellItems
            return header
        case UICollectionView.elementKindSectionFooter:
            let footer: ActivityIndicatorViewFooterView = collectionView.dequeueReusableCell(ofKind: kind, for: indexPath)
            return footer
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplaySupplementaryView view: UICollectionReusableView,
                        forElementKind elementKind: String,
                        at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter,
           let view = view as? ActivityIndicatorViewFooterView,
           viewModel.isPagingEnabled {
            view.startLoading()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplayingSupplementaryView view: UICollectionReusableView,
                        forElementOfKind elementKind: String,
                        at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter,
           let view = view as? ActivityIndicatorViewFooterView,
           viewModel.isPagingEnabled {
            view.stopLoading()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if viewModel.homeHeaderCellItems.isEmpty {
            return CGSize(width: collectionView.bounds.width, height: 0)
        }
        return CGSize(width: collectionView.bounds.width, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        let height: CGFloat = viewModel.isPagingEnabled ? 50 : 0
        return CGSize(width: collectionView.bounds.width, height: height)
    }
}

// MARK: - SubscribeViewModel
extension HomeViewController {
    
    func subcribeViewModel() {
        viewModel.getDataDidSuccess = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
        viewModel.reloadData = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}
