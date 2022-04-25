//
//  MovieDetailViewModel.swift
//  MovieList_I.Stakankov
//
//  Created by Golos on 23.04.2022.
//

import Kingfisher
import UIKit

protocol MovieDetailViewModelProtocol {
    var movieHandler: ((MovieResults) -> Void)? { get set }
    var posterHandler: ((UIImage?) -> Void)? { get set }
}

final class MovieDetailViewModel: MovieDetailViewModelProtocol {
    
    private let movieResults: MovieResults
    private let imageDownloader: ImageDownloaderProtocol
    
    var movieHandler: ((MovieResults) -> Void)?
    var posterHandler: ((UIImage?) -> Void)?
    
    init(movieResults: MovieResults, imageDownloader: ImageDownloaderProtocol) {
        self.movieResults = movieResults
        self.imageDownloader = imageDownloader
    }
}

//MARK: - ViewLifecycleModel

extension MovieDetailViewModel: ViewLifecycleModel {
    func viewDidLoaded() {
        movieHandler?(movieResults)
        imageDownloader.downloadImage(from: .imageName(movieResults.posterPath)) { [weak self] in
            self?.posterHandler?($0)
        }
    }
}
