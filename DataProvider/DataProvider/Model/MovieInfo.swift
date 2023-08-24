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
    public let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case date = "release_date"
        case overview
        case posterPath = "poster_path"
    }
}
