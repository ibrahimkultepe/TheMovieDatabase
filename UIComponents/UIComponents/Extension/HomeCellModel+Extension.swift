//
//  HomeCellModel+Extension.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 22.08.2023.
//

public extension HomeCellModel {
    
    convenience init(movie: MovieInfo) {
        self.init(posterPath: movie.posterPath,
                  title: movie.title,
                  overview: movie.overview,
                  date: movie.date)
    }
}
