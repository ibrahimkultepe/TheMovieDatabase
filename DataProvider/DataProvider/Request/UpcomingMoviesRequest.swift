//
//  UpcomingMoviesRequest.swift
//  DataProvider
//
//  Created by İbrahim Kültepe on 22.08.2023.
//

public struct UpcomingMoviesRequest: APIDecodableResponseRequest {
    
    public typealias ResponseType = MoviesResponse
    
    public let path: String = "movie/upcoming"
    public let method: RequestMethod = .get
    public var parameters: RequestParameters = [:]

    public init(page: Int) {
        self.parameters["api_key"] = Config.apiKey
        self.parameters["page"] = page
    }
}
