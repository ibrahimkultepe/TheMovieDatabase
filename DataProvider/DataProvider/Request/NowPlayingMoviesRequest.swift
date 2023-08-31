//
//  NowPlayingMoviesRequest.swift
//  DataProvider
//
//  Created by İbrahim Kültepe on 23.08.2023.
//

public struct NowPlayingMoviesRequest: APIDecodableResponseRequest {
            
    public typealias ResponseType = MoviesResponse

    public let path: String = "movie/now_playing"
    public let method: RequestMethod = .get
    public var parameters: RequestParameters = [:]

    public init() {
        self.parameters["api_key"] = Config.apiKey
    }
}
