//
//  HomeCellModel.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 17.08.2023.
//

public protocol HomeCellModelDataSource: AnyObject {
    var posterPath: String? { get }
    var title: String? { get }
    var overview: String? { get }
    var date: String? { get }
}

public protocol HomeCellModelEventSource: AnyObject {
}

public protocol HomeCellModelProtocol: HomeCellModelDataSource, HomeCellModelEventSource {
}

public final class HomeCellModel: HomeCellModelProtocol {
    
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
