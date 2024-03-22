//
//  HomePagesInteractor.swift
//  TMDBView
//
//  Created Cuitlahuac Danielon 25/02/23.
//

import Foundation

class HomePagesInteractor: HomePagesInteractorProtocol {
    //MARK: - Protocol Properties
    var presenter: HomePagesPresenterProtocol?
    static let shared = HomePagesInteractor()
    
    //MARK: - Properties
    private let apiKey = "a3f051db251ff094eccfd3fde09c846b"
    private let baseAPIURL = "https://api.themoviedb.org/3"
    
    //MARK: - Methods
    func getListOfPopularMovies() async throws -> PopularMovieResponseEntity {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=a3f051db251ff094eccfd3fde09c846b") else {
            throw NetworkError.invalidURL
        }
        
        do {
            presenter?.activateLoader()
            let (data, _) = try await URLSession.shared.data(from: url)
            let result = try JSONDecoder().decode(PopularMovieResponseEntity.self, from: data)
            
            if !result.results.isEmpty {
                presenter?.disableLoader()
            }
            
            return result
        } catch {
            print("CAFV PENDIENTE MOSTRAR PANTALLA DE ERROR POPULAR. error: ", error.localizedDescription)
            throw error
        }
    }
    
    func getListOfTopRatedMovies() async throws -> TopRatedMovieResponseEntity {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=a3f051db251ff094eccfd3fde09c846b") else {
            throw NetworkError.invalidURL
        }
        
        do {
            presenter?.activateLoader()
            let (data, _) = try await URLSession.shared.data(from: url)
            let result = try JSONDecoder().decode(TopRatedMovieResponseEntity.self, from: data)
            
            if !result.results.isEmpty {
                presenter?.disableLoader()
            }
            
            return result
        } catch {
            print("CAFV PENDIENTE MOSTRAR PANTALLA DE ERROR TOP RATED. error: ", error.localizedDescription)
            throw error
        }
    }
    
    func getListOfOnTV() async throws -> OnTVResponseEntity {
        guard let url = URL(string: "https://api.themoviedb.org/3/tv/on_the_air?api_key=a3f051db251ff094eccfd3fde09c846b") else {
            throw NetworkError.invalidURL
        }
        
        do {
            presenter?.activateLoader()
            let (data, _) = try await URLSession.shared.data(from: url)
            let result = try JSONDecoder().decode(OnTVResponseEntity.self, from: data)
            
            if !result.results.isEmpty {
                presenter?.disableLoader()
            }
            
            return result
        } catch {
            print("CAFV PENDIENTE MOSTRAR PANTALLA DE ERROR ON TV. error: ", error.localizedDescription)
            throw error
        }
    }
    
    func getListAiringToday() async throws -> AiringTodayResponseEntity {
        guard let url = URL(string: "https://api.themoviedb.org/3/tv/airing_today?api_key=a3f051db251ff094eccfd3fde09c846b") else {
            throw NetworkError.invalidURL
        }
        
        do {
            presenter?.activateLoader()
            let (data, _) = try await URLSession.shared.data(from: url)
            let result = try JSONDecoder().decode(AiringTodayResponseEntity.self, from: data)
            
            if !result.results.isEmpty {
                presenter?.disableLoader()
            }
            
            return result
        } catch {
            print("CAFV PENDIENTE MOSTRAR PANTALLA DE ERROR AIRING TODAY. error: ", error.localizedDescription)
            throw error
        }
    }
}

enum NetworkError: Error {
    case noInternetConnection
    case invalidURL
    case serverError
    case decodingError
    case invalidResponse
    // Agregue otros errores personalizados según sea necesario
}
