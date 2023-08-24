//
//  GetNowPlayingMoviesRequest.swift
//  DataProvider
//
//  Created by İbrahim Kültepe on 23.08.2023.
//

public struct GetNowPlayingMoviesRequest: APIDecodableResponseRequest {
            
    public typealias ResponseType = MoviesResponse

    public let path: String = "now_playing"
    public let method: RequestMethod = .get
    public var parameters: RequestParameters = [:]

    public init() {
        self.parameters["api_key"] = Config.apiKey
    }
}
