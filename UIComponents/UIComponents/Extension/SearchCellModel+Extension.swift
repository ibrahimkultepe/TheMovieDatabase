//
//  SearchCellModel+Extension.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 28.08.2023.
//

public extension SearchCellModel {
    
    convenience init(movie: MovieInfo) {
        let apiDate = Date.from(movie.date ?? "", format: .custom(rawValue: "yyyy-dd-mm"))
        let displayDateString = apiDate?.to(.custom(rawValue: "(yyyy)"))
        
        self.init(title: movie.title,
                  date: displayDateString,
                  movieId: movie.movieId)
    }
}
