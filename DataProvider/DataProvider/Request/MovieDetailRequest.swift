//
//  MovieDetailRequest.swift
//  DataProvider
//
//  Created by İbrahim Kültepe on 5.09.2023.
//

public struct MovieDetailRequest: APIDecodableResponseRequest {
    
    public typealias ResponseType = MovieDetail
    
    public var path: String = ""
    public let method: RequestMethod = .get
    public var parameters: RequestParameters = [:]
    
    public init(movieId: Int) {
        self.parameters["api_key"] = Config.apiKey
        self.path = "movie/\(movieId)"
    }
}
