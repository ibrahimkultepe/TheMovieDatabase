//
//  SearchViewModel.swift
//  TheMovieDatabase
//
//  Created by İbrahim Kültepe on 28.08.2023.
//

protocol SearchViewDataSource {}

protocol SearchViewEventSource {}

protocol SearchViewProtocol: SearchViewDataSource, SearchViewEventSource {}

final class SearchViewModel: BaseViewModel<SearchRouter>, SearchViewProtocol {
    
    var reloadData: VoidClosure?

    public var cellItems: [SearchCellModelProtocol] = [] {
        didSet {
            reloadData?()
        }
    }
}

// MARK: - Actions
extension SearchViewModel {
    
    func didSelectMovieDetail(indexPath: IndexPath) {
        let movieId = cellItems[indexPath.row].movieId
        router.pushMovieDetail(movieId: movieId)
    }
}
