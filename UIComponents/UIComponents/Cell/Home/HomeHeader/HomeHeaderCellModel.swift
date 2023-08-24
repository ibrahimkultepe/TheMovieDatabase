//
//  HomeHeaderCellModel.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 23.08.2023.
//

public protocol HomeHeaderCellModelDataSource: AnyObject {
    var posterPath: String? { get }
    var title: String? { get }
    var overview: String? { get }
}

public protocol HomeHeaderCellModelEventSource: AnyObject {
}

public protocol HomeHeaderCellModelProtocol: HomeHeaderCellModelDataSource, HomeHeaderCellModelEventSource {
}

public final class HomeHeaderCellModel: HomeHeaderCellModelProtocol {
    
    public var posterPath: String?
    public var title: String?
    public var overview: String?
    
    public init(posterPath: String?, title: String?, overview: String?) {
        self.posterPath = posterPath
        self.title = title
        self.overview = overview
    }
}
