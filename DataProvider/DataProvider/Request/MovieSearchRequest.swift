//
//  MovieSearchRequest.swift
//  DataProvider
//
//  Created by İbrahim Kültepe on 27.08.2023.
//

public struct MovieSearchRequest: APIDecodableResponseRequest {
            
    public typealias ResponseType = MoviesResponse

    public let path: String = "search/movie"
    public let method: RequestMethod = .get
    public var parameters: RequestParameters = [:]

    public init(query: String) {
        self.parameters["api_key"] = Config.apiKey
        self.parameters["query"] = query
    }
}
