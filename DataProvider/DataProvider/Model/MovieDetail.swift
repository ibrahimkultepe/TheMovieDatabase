//
//  MovieDetail.swift
//  DataProvider
//
//  Created by İbrahim Kültepe on 5.09.2023.
//

public struct MovieDetail: Decodable {
    public let backdropPath: String?
    public let movieRating: Double
    public let date: String?
    public let title: String?
    public let overview: String?
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case movieRating = "vote_average"
        case date = "release_date"
        case title
        case overview
    }
}
