//
//  MainCellModel.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 17.08.2023.
//

public protocol MainCellModelDataSource: AnyObject {
    var image: UIImage { get }
    var title: String { get }
    var description: String { get }
    var date: String { get }
}

public protocol MainCellModelEventSource: AnyObject {
}

public protocol MainCellModelProtocol: MainCellModelDataSource, MainCellModelEventSource {
}

public final class MainCellModel: MainCellModelProtocol {
    
    public var image: UIImage
    public var title: String
    public var description: String
    public var date: String
    
    public init(image: UIImage, title: String, description: String, date: String) {
        self.image = image
        self.title = title
        self.description = description
        self.date = date
    }
}
