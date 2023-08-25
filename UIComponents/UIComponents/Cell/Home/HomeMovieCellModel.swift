//
//  HomeMovieCellModel.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 17.08.2023.
//

public protocol HomeMovieCellModelDataSource: AnyObject {
    var posterPath: String? { get }
    var title: String? { get }
    var overview: String? { get }
    var date: String? { get }
}

public protocol HomeMovieCellModelEventSource: AnyObject {
}

public protocol HomeMovieCellModelProtocol: HomeMovieCellModelDataSource, HomeMovieCellModelEventSource {
}

public final class HomeMovieCellModel: HomeMovieCellModelProtocol {
    
    public var posterPath: String?
    public var title: String?
    public var overview: String?
    public var date: String?
    
    public init(posterPath: String?, title: String?, overview: String?, date: String?) {
        self.posterPath = posterPath
        self.title = title
        self.overview = overview
        self.date = date
    }
}
