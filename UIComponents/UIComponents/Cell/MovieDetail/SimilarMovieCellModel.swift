//
//  SimilarMovieCellModel.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 4.09.2023.
//

public protocol SimilarMovieCellModelDataSource: AnyObject {
    var backdropPath: String? { get }
    var title: String? { get }
    var movieId: Int { get }
}

public protocol SimilarMovieCellModelEventSource: AnyObject {
}

public protocol SimilarMovieCellModelProtocol: SimilarMovieCellModelDataSource, SimilarMovieCellModelEventSource {
}

public final class SimilarMovieCellModel: SimilarMovieCellModelProtocol {
    
    public var backdropPath: String?
    public var title: String?
    public var movieId: Int
    
    public init(backdropPath: String?, title: String?, movieId: Int) {
        self.backdropPath = backdropPath
        self.title = title
        self.movieId = movieId
    }
}
