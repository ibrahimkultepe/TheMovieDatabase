//
//  HomeViewModel.swift
//  TheMovieDatabase
//
//  Created by İbrahim Kültepe on 15.08.2023.
//

protocol HomeViewDataSource {}

protocol HomeViewEventSource {}

protocol HomeViewProtocol: HomeViewDataSource, HomeViewEventSource {}

final class HomeViewModel: BaseViewModel<HomeRouter>, HomeViewProtocol {
    
    private var page = 1
    
    var searchMovies = [SearchCellModelProtocol]()
    
    var isPagingEnabled = false
    var isRequestEnabled = false
    
    private var isGetUpcomingMovieSuccess = false
    private var isGetNowPlayingMovieSuccess = false
    private let dispatchGroup = DispatchGroup()
    
    var getDataDidSuccess: VoidClosure?
    var reloadData: VoidClosure?
    
    private var cellItems = [HomeMovieCellModelProtocol]()
    var homeHeaderCellItems = [HomeHeaderCellModelProtocol]()
    
    var numberOfItems: Int {
        return cellItems.count
    }
    
    func cellItemForAt(indexPath: IndexPath) -> HomeMovieCellModelProtocol {
        return cellItems[indexPath.row]
    }
    
    override func tryAgainButtonTapped() {
        self.hideTryAgainButton?()
        getData(showLoading: true)
    }
    
    func refreshData() {
        cellItems.removeAll()
        homeHeaderCellItems.removeAll()
        page = 1
        self.reloadData?()
        self.isPagingEnabled = false
        isGetUpcomingMovieSuccess = false
        isGetNowPlayingMovieSuccess = false
        getData(showLoading: false)
    }
}

// MARK: - Network
extension HomeViewModel {
    
    func getUpcomingMovies() {
        let request = UpcomingMoviesRequest(page: page)
        self.isRequestEnabled = true
        dispatchGroup.enter()
        dataProvider.request(for: request) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                let cellItems = response.results.map( {HomeMovieCellModel(movie: $0) })
                self.cellItems.append(contentsOf: cellItems)
                self.page += 1
                self.isPagingEnabled = response.totalPage > response.page
                self.isGetUpcomingMovieSuccess = true
                self.reloadData?()
            case .failure(let error):
                self.showWarningToast?(error.localizedDescription)
            }
            self.isRequestEnabled = false
            self.dispatchGroup.leave()
        }
    }
    
    private func getNowPlayingMovies() {
        let request = NowPlayingMoviesRequest()
        dispatchGroup.enter()
        dataProvider.request(for: request) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                let homeHeaderCellItems = response.results.map( {HomeHeaderCellModel(movie: $0) })
                self.homeHeaderCellItems.append(contentsOf: homeHeaderCellItems)
                self.isGetNowPlayingMovieSuccess = true
                self.reloadData?()
            case .failure(let error):
                self.showWarningToast?(error.localizedDescription)
            }
            self.dispatchGroup.leave()
        }
    }
    
    func searchMovies(query: String) {
        let request = MovieSearchRequest(query: query)
        self.showActivityIndicatorView?()
        dataProvider.request(for: request) { [weak self] (result) in
            guard let self = self else { return }
            self.hideActivityIndicatorView?()
            switch result {
            case .success(let response):
                let searchMovies = response.results.map( {SearchCellModel(movie: $0) })
                self.searchMovies.append(contentsOf: searchMovies)
            case .failure(let error):
                self.showWarningToast?(error.localizedDescription)
            }
        }
    }
    
    func getData(showLoading: Bool) {
        if showLoading && (!isGetUpcomingMovieSuccess || !isGetNowPlayingMovieSuccess) {
            showActivityIndicatorView?()
        }
        
        if !isGetUpcomingMovieSuccess {
            getUpcomingMovies()
        }
        
        if !isGetNowPlayingMovieSuccess {
            getNowPlayingMovies()
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) { [weak self] in
            guard let self = self else { return }
            self.hideActivityIndicatorView?()
            if self.isGetUpcomingMovieSuccess && self.isGetNowPlayingMovieSuccess {
                self.getDataDidSuccess?()
            } else {
                self.showTryAgainButton?()
            }
        }
    }
}
