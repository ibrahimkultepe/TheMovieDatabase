//
//  HomeMovieCellModel+Extension.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 22.08.2023.
//

import MobilliumDateFormatter

public extension HomeMovieCellModel {
    
    convenience init(movie: MovieInfo) {
        let apiDate = Date.from(movie.date ?? "", format: .custom(rawValue: "yyyy-dd-mm"))
        let displayDateString = apiDate?.to(.custom(rawValue: "dd.mm.yyyy"))
        
        self.init(backdropPath: movie.backdropPath,
                  title: movie.title,
                  overview: movie.overview,
                  date: displayDateString,
                  movieId: movie.movieId)
    }
}
