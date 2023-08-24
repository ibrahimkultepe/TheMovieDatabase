//
//  HomeRoute.swift
//  TheMovieDatabase
//
//  Created by İbrahim Kültepe on 15.08.2023.
//

protocol HomeRoute {
    func placeOnWindowHome()
}

extension HomeRoute where Self: RouterProtocol {
    
    func placeOnWindowHome() {
        let router = HomeRouter()
        let viewModel = HomeViewModel(router: router)
        let viewController = HomeViewController(viewModel: viewModel)
        let navController = UINavigationController(rootViewController: viewController)
        
        let transition = PlaceOnWindowTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        open(navController, transition: transition)
    }
}
