//
//  HomePagesEntities.swift
//  TMDBView
//
//  Created by Cuitlahuac Daniel on 26/02/23.
//

import Foundation

struct PopularMovieResponseEntity: Decodable {
    let results: [MovieEntity]
}

struct TopRatedMovieResponseEntity: Decodable {
    let results: [MovieEntity]
}

struct OnTVResponseEntity: Decodable {
    let results: [TVEntity]
}

struct AiringTodayResponseEntity: Decodable {
    let results: [TVEntity]
}

struct MovieEntity: Decodable {
    var id: Int
    var title: String
    var overview: String
    var poster_path: String
    var release_date: String
    var original_language: String
    var vote_average: Double
    var vote_count: Int
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case poster_path = "poster_path"
        case release_date = "release_date"
        case original_language = "original_language"
        case vote_average = "vote_average"
        case vote_count
    }
}

struct TVEntity: Decodable {
    var id: Int
    var name: String
    var overview: String
    var poster_path: String
    var first_air_date: String
    var original_language: String
    var vote_average: Double
    var vote_count: Int
    
    enum CodingKeys: String, CodingKey {
        case id, name, overview
        case poster_path = "poster_path"
        case first_air_date = "first_air_date"
        case original_language = "original_language"
        case vote_average = "vote_average"
        case vote_count
    }
}

enum AllCategories: Int {
    case popular = 0
    case topRated = 1
    case OnTV = 2
    case AiringToday = 3
}

enum PopularAndTopRated: Int {
    case popular = 0
    case topRated = 1
}

enum OnTVAndAiringToday: Int {
    case OnTV = 2
    case AiringToday = 3
}
