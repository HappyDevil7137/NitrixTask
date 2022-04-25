//
//  MovieListViewModel.swift
//  MovieList_I.Stakankov
//
//  Created by Golos on 24.04.2022.
//

import UIKit

protocol MovieListViewProtocol {
    var reloadTableHandler: (() -> Void)? { get set }
    var addMovieHandler: ((MovieResults) -> Void)? { get set }
    var dataArray: [MovieResults] { get }
    
    func addMovie(with index: Int)
    func loadData()
}

final class MovieListViewModel: MovieListViewProtocol {
    private let networkController: NetworkControllerProtocol
    
    private(set) var dataArray = [MovieResults]()
    private var fetchingMore = false
    private var indexOfpageRequest = 1
    
    var reloadTableHandler: (() -> Void)?
    var addMovieHandler: ((MovieResults) -> Void)?
    
    init(networkController: NetworkControllerProtocol) {
        self.networkController = networkController
    }
    
    func addMovie(with index: Int) {
        guard let item = dataArray.element(at: index) else { return }
        addMovieHandler?(item)
    }
    
    func loadData() {
        guard !fetchingMore else { return }
        fetchingMore = true
        networkController.getRequest(request: .moviesTopList(page: indexOfpageRequest)) { [weak self] response in
            switch response {
            case let .success(movies):
                self?.indexOfpageRequest += 1
                self?.dataArray += movies.results
            case let .failure(error):
                NSLog(error.localizedDescription)
            }
            DispatchQueue.main.async {
                self?.reloadTableHandler?()
                self?.fetchingMore = false
            }
        }
    }
}

//MARK: - ViewLifecycleModel

extension MovieListViewModel: ViewLifecycleModel {
    func viewDidLoaded() {
        loadData()
    }
}
