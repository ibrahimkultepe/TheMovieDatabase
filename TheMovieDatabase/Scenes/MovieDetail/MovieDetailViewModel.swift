//
//  MovieDetailViewModel.swift
//  TheMovieDatabase
//
//  Created by İbrahim Kültepe on 2.09.2023.
//

protocol MovieDetailViewDataSource {}

protocol MovieDetailViewEventSource {}

protocol MovieDetailViewProtocol: MovieDetailViewDataSource, MovieDetailViewEventSource {}

final class MovieDetailViewModel: BaseViewModel<MovieDetailRouter>, MovieDetailViewProtocol {
    
    var movieId: Int
    var backdropPath: String?
    var movieRating: String?
    var date: String?
    var title: String?
    var overview: String?
    var starRating: Double?

    var getDataDidSuccess: VoidClosure?

    private var cellItems = [SimilarMovieCellModelProtocol]()
    
    var numberOfItems: Int {
        return cellItems.count
    }
    
    func cellItemForAt(indexPath: IndexPath) -> SimilarMovieCellModelProtocol {
        return cellItems[indexPath.row]
    }

    private func setItem(movieDetail: MovieDetail) {
        let apiDate = Date.from(movieDetail.date ?? "", format: .custom(rawValue: "yyyy-dd-mm"))
        let displayDateString = apiDate?.to(.custom(rawValue: "(yyyy)"))

        backdropPath = movieDetail.backdropPath
        movieRating = String(format: "%.1f", movieDetail.movieRating)
        date = apiDate?.to(.custom(rawValue: "dd.mm.yyyy"))
        title = "\(movieDetail.title ?? "")  \(displayDateString ?? "")"
        overview = movieDetail.overview
        starRating = movieDetail.movieRating
    }
    
    init(movieId: Int, router: MovieDetailRouter) {
        self.movieId = movieId
        super.init(router: router)
    }
}

// MARK: - Actions
extension MovieDetailViewModel {
    
    func didSelectMovieDetail(indexPath: IndexPath) {
        let movieId = cellItems[indexPath.row].movieId
        router.pushMovieDetail(movieId: movieId)
    }
}

// MARK: - Network
extension MovieDetailViewModel {
    
    func getMovieDetail() {
        let request = MovieDetailRequest(movieId: movieId)
        self.showActivityIndicatorView?()
        dataProvider.request(for: request) { [weak self] (result) in
            guard let self = self else { return }
            self.hideActivityIndicatorView?()
            switch result {
            case .success(let response):
                self.setItem(movieDetail: response)
                self.getDataDidSuccess?()
            case .failure(let error):
                self.showWarningToast?(error.localizedDescription)
            }
        }
    }
    
    func getMovieSimilar() {
        let request = SimilarMoviesRequest(movieId: movieId)
        self.showActivityIndicatorView?()
        dataProvider.request(for: request) { [weak self] (result) in
            guard let self = self else { return }
            self.hideActivityIndicatorView?()
            switch result {
            case .success(let response):
                let cellItems = response.results.map( {SimilarMovieCellModel(movieSimilar: $0) })
                self.cellItems.append(contentsOf: cellItems)
                self.getDataDidSuccess?()
            case .failure(let error):
                self.showWarningToast?(error.localizedDescription)
            }
        }
    }
}
