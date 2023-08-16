//
//  AppRouter.swift
//  TheMovieDatabase
//
//  Created by İbrahim Kültepe on 15.08.2023.
//

import UIKit

final class AppRouter: Router, AppRouter.Routes {
    
    typealias Routes = MainRoute
    
    static let shared = AppRouter()
    
    func startApp() {
        placeOnWindowWalkthrough()
    }
}
