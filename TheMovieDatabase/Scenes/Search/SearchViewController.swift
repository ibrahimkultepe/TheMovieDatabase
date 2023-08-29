//
//  SearchViewController.swift
//  TheMovieDatabase
//
//  Created by İbrahim Kültepe on 28.08.2023.
//

final class SearchViewController: BaseViewController<SearchViewModel> {
    
    private let collectionView = UICollectionViewBuilder()
        .backgroundColor(.appZircon)
        .scrollDirection(.vertical)
        .isHidden(true)
        .build()
    
    public var cellItems: [SearchCellModelProtocol] = [] {
        didSet {
            collectionView.reloadData()
            collectionView.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureContent()
    }
}

// MARK: - UILayout
extension SearchViewController {
    
    private func addSubviews() {
        view.addSubview(collectionView)
        collectionView.edgesToSuperview(usingSafeArea: true)
    }
}

// MARK: - ConfigureContent
extension SearchViewController {
    
    private func configureContent() {
        collectionView.register(SearchCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

// MARK: - UICollectionViewDataSource
extension SearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SearchCell = collectionView.dequeueReusableCell(for: indexPath)
        let cellItem = cellItems[indexPath.row]
        cell.setCellItem(viewModel: cellItem)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
