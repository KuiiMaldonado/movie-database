//
//  HomePagesProtocols.swift
//  TMDBView
//
//  Created Cuitlahuac Daniel on 25/02/23.
//

import Foundation

//MARK: Wireframe -
protocol HomePagesWireframeProtocol: AnyObject {
}

//MARK: Presenter -
protocol HomePagesPresenterProtocol {
    func fetch(category: AllCategories)
    func activateLoader()
    func disableLoader()
}

//MARK: Interactor -
protocol HomePagesInteractorProtocol: AnyObject {
    var presenter: HomePagesPresenterProtocol?  { get set }
    func getListOfPopularMovies() async throws -> PopularMovieResponseEntity
    func getListOfTopRatedMovies() async throws -> TopRatedMovieResponseEntity
    func getListOfOnTV() async throws -> OnTVResponseEntity
    func getListAiringToday() async throws -> AiringTodayResponseEntity
}

//MARK: View -
protocol HomePagesViewProtocol: AnyObject {
    var presenter: HomePagesPresenterProtocol?  { get set }
    func showMovies(category: PopularAndTopRated, movies: [MovieEntity])
    func showTVPrograms(category: OnTVAndAiringToday, movies: [TVEntity])
    @MainActor func showLoader(_ active: Bool) async throws
}

//MARK: RootPageViewControllers -
protocol RootPageProtocol : AnyObject {
    func currentPage(_ category : AllCategories)
}

//MARK: CategoriesView -
protocol TabsViewProtocol : AnyObject {
    func didSelectOption(index : Int)
}
