//
//  SimilarMovieCellModel+Extension.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 5.09.2023.
//

public extension SimilarMovieCellModel {
    
    convenience init(movieSimilar: MovieInfo) {
        let apiDate = Date.from(movieSimilar.date ?? "", format: .custom(rawValue: "yyyy-dd-mm"))
        let displayDateString = apiDate?.to(.custom(rawValue: "(yyyy)"))
        
        self.init(backdropPath: movieSimilar.backdropPath,
                  title: "\(movieSimilar.title ?? "")" +  " \(displayDateString ?? "")",
                  movieId: movieSimilar.movieId)
    }
}
