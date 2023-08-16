//
//  MainViewModel.swift
//  TheMovieDatabase
//
//  Created by İbrahim Kültepe on 15.08.2023.
//

protocol MainViewDataSource {}

protocol MainViewEventSource {}

protocol MainViewProtocol: MainViewDataSource, MainViewEventSource {}

final class MainViewModel: BaseViewModel<MainRouter>, MainViewProtocol {
    

}

