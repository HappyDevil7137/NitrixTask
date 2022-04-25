//
//  ApiRequest.swift
//  MovieList_I.Stakankov
//
//  Created by Golos on 02.05.2022.
//

import Foundation

struct ApiRequest<T> {
    let url: String
    var getParameters: [String: String] = [:]
}

extension ApiRequest {
    
    static func moviesTopList(page: Int) -> ApiRequest<MovieResponse> {
        .init(url: "/3/movie/top_rated", getParameters: ["page": String(page)])
    }
}
