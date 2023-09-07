//
//  HomeMovieCellModel.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 17.08.2023.
//

public protocol HomeMovieCellModelDataSource: AnyObject {
    var backdropPath: String? { get }
    var title: String? { get }
    var overview: String? { get }
    var date: String? { get }
    var movieId: Int { get }
}

public protocol HomeMovieCellModelEventSource: AnyObject {
}

public protocol HomeMovieCellModelProtocol: HomeMovieCellModelDataSource, HomeMovieCellModelEventSource {
}

public final class HomeMovieCellModel: HomeMovieCellModelProtocol {
    
    public var backdropPath: String?
    public var title: String?
    public var overview: String?
    public var date: String?
    public var movieId: Int
    
    public init(backdropPath: String?, title: String?, overview: String?, date: String?, movieId: Int) {
        self.backdropPath = backdropPath
        self.title = title
        self.overview = overview
        self.date = date
        self.movieId = movieId
    }
}
