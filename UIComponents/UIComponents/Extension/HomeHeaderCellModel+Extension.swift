//
//  HomeHeaderCellModel+Extension.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 23.08.2023.
//

public extension HomeHeaderCellModel {
    
    convenience init(movie: MovieInfo) {
        self.init(posterPath: movie.posterPath,
                  title: movie.title,
                  overview: movie.overview)
    }
}
