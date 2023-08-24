//
//  MoviesResponse.swift
//  DataProvider
//
//  Created by İbrahim Kültepe on 22.08.2023.
//

public struct MoviesResponse: Decodable {
    public let page: Int
    public let results: [MovieInfo]
    public let totalPage: Int
    public let totalResult: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPage = "total_pages"
        case totalResult = "total_results"
    }
}
