//
//  FavoriteListViewModel.swift
//  MovieList_I.Stakankov
//
//  Created by Golos on 24.04.2022.
//

import Foundation

protocol FavoriteListViewModelProtocol {
    var dataArray: [MovieResults] { get }
    
    func deleteMovies(for pathes: [IndexPath])
    func addMovies(_ movie: MovieResults)
}

final class FavoriteListViewModel: FavoriteListViewModelProtocol {
    private(set) var dataArray = [MovieResults]()
    
    @objc func deleteMovies(for pathes: [IndexPath]) {
        let itemsToDelete = pathes.compactMap { dataArray.element(at: $0.item) }
        dataArray.removeAll(where: itemsToDelete.contains)
    }
    
    func addMovies(_ movie: MovieResults) {
        guard !dataArray.contains(movie) else { return }
        dataArray.append(movie)
    }
}
