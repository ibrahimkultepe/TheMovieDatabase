//
//  MovieInfo.swift
//  DataProvider
//
//  Created by İbrahim Kültepe on 22.08.2023.
//

public struct MovieInfo: Decodable {
    public let title: String?
    public let date: String?
    public let overview: String?
    public let backdropPath: String?
    public let movieId: Int
    
    enum CodingKeys: String, CodingKey {
        case title
        case date = "release_date"
        case overview
        case backdropPath = "backdrop_path"
        case movieId = "id"
    }
}
