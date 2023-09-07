//
//  SearchCellModel.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 28.08.2023.
//

public protocol SearchCellModelDataSource: AnyObject {
    var title: String? { get }
    var date: String? { get }
    var movieId: Int { get }
}

public protocol SearchCellModelEventSource: AnyObject {
}

public protocol SearchCellModelProtocol: SearchCellModelDataSource, SearchCellModelEventSource {
}

public final class SearchCellModel: SearchCellModelProtocol {
    
    public var title: String?
    public var date: String?
    public var movieId: Int

    public init(title: String?, date: String?, movieId: Int) {
        self.title = title
        self.date = date
        self.movieId = movieId
    }
}
