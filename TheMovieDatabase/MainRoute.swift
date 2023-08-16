//
//  MainRoute.swift
//  TheMovieDatabase
//
//  Created by İbrahim Kültepe on 15.08.2023.
//

protocol MainRoute {
    func placeOnWindowWalkthrough()
}

extension MainRoute where Self: RouterProtocol {
    
    func placeOnWindowWalkthrough() {
        let router = MainRouter()
        let viewModel = MainViewModel(router: router)
        let viewController = MainViewController(viewModel: viewModel)
        let navController = UINavigationController(rootViewController: viewController)
        
        let transition = PlaceOnWindowTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        open(navController, transition: transition)
    }
}
