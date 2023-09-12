//
//  HomeViewController.swift
//  TheMovieDatabase
//
//  Created by İbrahim Kültepe on 15.08.2023.
//

final class HomeViewController: BaseViewController<HomeViewModel> {
    
    private let refreshControl = UIRefreshControl()
    
    private lazy var searchController: UISearchController = {
        let searchRouter = SearchRouter()
        let searchViewModel = SearchViewModel(router: searchRouter)
        let searchViewController = SearchViewController(viewModel: searchViewModel)
        searchRouter.viewController = self
        
        let searchController = UISearchController(searchResultsController: searchViewController)
        searchController.searchResultsUpdater = self
        return searchController
    }()
    
    private let collectionView = UICollectionViewBuilder()
        .backgroundColor(.clear)
        .scrollDirection(.vertical)
        .build()
    
    private var searchTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureContent()
        setLocalize()
        subcribeViewModel()
        viewModel.getData(showLoading: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchTimer?.invalidate()
        searchTimer = nil
    }
}

// MARK: - UILayout
extension HomeViewController {
    
    private func addSubviews() {
        view.addSubview(collectionView)
        collectionView.edgesToSuperview(usingSafeArea: true)
    }
}

// MARK: - ConfigureContent
extension HomeViewController {
    
    private func configureContent() {
        definesPresentationContext = true
        collectionView.register(HomeMovieCell.self)
        collectionView.registerHeader(HomeHeaderView.self)
        collectionView.registerFooter(ActivityIndicatorViewFooterView.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.searchTextField.clearButtonMode = .never
        searchController.searchBar.delegate = self
        navigationItem.titleView = searchController.searchBar
    }
}

// MARK: - SetLocalize
extension HomeViewController {
    
    private func setLocalize() {
        searchController.searchBar.placeholder = L10n.Home.searchControllerText
    }
}

// MARK: - Actions
extension HomeViewController {
    
    @objc
    private func refreshData() {
        viewModel.refreshData()
    }
}

// MARK: - UISearchResultsUpdating
extension HomeViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        searchTimer?.invalidate()
        searchTimer = nil
        guard let searchText = searchController.searchBar.text else { return }
        
        if searchText.count >= 3 {
            searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
                self?.viewModel.searchMovies(query: searchText)
                let searchViewController = searchController.searchResultsController as? SearchViewController
                searchViewController?.viewModel.cellItems = self?.viewModel.searchMovieItems ?? []
                self?.viewModel.searchMovieItems.removeAll()
            })
        } else if searchText.isEmpty {
            let searchViewController = searchController.searchResultsController as? SearchViewController
            searchViewController?.viewModel.cellItems.removeAll()
            viewModel.searchMovieItems.removeAll()
        }
    }
}

// MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        let searchViewController = searchController.searchResultsController as? SearchViewController
        searchViewController?.viewModel.cellItems.removeAll()
        viewModel.searchMovieItems.removeAll()
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectMovieDetail(indexPath: indexPath)
    }
    
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
            header.didSelectItemAtHomeHeaderView = { [weak self] movieId in
                guard let self = self else { return }
                self.viewModel.didSelectHeaderMovieDetail(indexPath: indexPath, movieId: movieId)
            }
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
