//
//  HomePagesPresenter.swift
//  TMDBView
//
//  Created Cuitlahuac Daniel on 25/02/23.
//

import UIKit

class HomePagesPresenter {
    //MARK: - Protocol Properties
    weak private var view: HomePagesViewProtocol?
    var interactor: HomePagesInteractorProtocol?
    private let router: HomePagesWireframeProtocol
    
    //MARK: - Life Cycle
    init(interface: HomePagesViewProtocol, interactor: HomePagesInteractorProtocol?, router: HomePagesWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
}

//MARK: - Presenter Methods
extension HomePagesPresenter: HomePagesPresenterProtocol {
    func fetch(category: AllCategories) {
        switch category {
        case .popular:
            Task {
                let popularModels = try await self.interactor?.getListOfPopularMovies()
                let emptyData : [MovieEntity] = []
                view?.showMovies(category: .popular, movies: popularModels?.results ?? emptyData)
            }
        case .topRated:
            Task {
                let topRatedModels = try await self.interactor?.getListOfTopRatedMovies()
                let emptyData : [MovieEntity] = []
                view?.showMovies(category: .topRated, movies: topRatedModels?.results ?? emptyData)
            }
        case .OnTV:
            Task {
                let onTVModels = try await self.interactor?.getListOfOnTV()
                let emptyData : [TVEntity] = []
                view?.showTVPrograms(category: .OnTV, movies: onTVModels?.results ?? emptyData)
            }
        case .AiringToday:
            Task {
                let airingToday = try await self.interactor?.getListAiringToday()
                let emptyData : [TVEntity] = []
                view?.showTVPrograms(category: .AiringToday, movies: airingToday?.results ?? emptyData)
            }
        }
    }
    func activateLoader() {
        Task {
            try await view?.showLoader(true)
        }
    }
    func disableLoader() {
        Task {
            try await view?.showLoader(false)
        }
    }
}
