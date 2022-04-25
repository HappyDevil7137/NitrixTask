//
//  SerachItems.swift
//  MovieList_I.Stakankov
//
//  Created by Golos on 22.04.2022.
//

import Foundation

struct MovieResponse: Codable {
    let results: [MovieResults]
}

struct MovieResults: Codable, Hashable {
    enum CodingKeys: String, CodingKey {
        case title, popularity, overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    let title: String
    let overview: String
    let posterPath: String
    let releaseDate: String
    let originalLanguage: String
    let originalTitle: String
    let popularity: Double
    let voteAverage: Double
    let voteCount: Int
}
