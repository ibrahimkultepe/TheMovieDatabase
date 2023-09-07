//
//  HomeHeaderCellModel.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 23.08.2023.
//

public protocol HomeHeaderCellModelDataSource: AnyObject {
    var backdropPath: String? { get }
    var title: String? { get }
    var overview: String? { get }
    var movieId: Int { get }
}

public protocol HomeHeaderCellModelEventSource: AnyObject {
}

public protocol HomeHeaderCellModelProtocol: HomeHeaderCellModelDataSource, HomeHeaderCellModelEventSource {
}

public final class HomeHeaderCellModel: HomeHeaderCellModelProtocol {
    
    public var backdropPath: String?
    public var title: String?
    public var overview: String?
    public var movieId: Int
    
    public init(backdropPath: String?, title: String?, overview: String?, movieId: Int) {
        self.backdropPath = backdropPath
        self.title = title
        self.overview = overview
        self.movieId = movieId
    }
}
