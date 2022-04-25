//
//  File.swift
//  MovieList_I.Stakankov
//
//  Created by Golos on 22.04.2022.
//

import UIKit

struct ControllersFactory {
    private enum Constants {
        static let borderWidth: CGFloat = 0.7
        static let cornerRadius: CGFloat = 20
        static let borderColor: CGColor = .init(red: 255, green: 140, blue: 0, alpha: 1)
        static let tintColor: UIColor = .systemOrange
        static let backgroundColor: UIColor = .black
        static let movieListStorybordID = "MovieListID"
    }
    
    static func createTabBarAndNavigation(
        firstVC: MovieListViewController?,
        secondVC: FavoriteListViewController
    ) -> UIViewController? {
        let tabBarController = UITabBarController()
        let movieListNavigationVC = UINavigationController(rootViewController: firstVC ?? .init())
        let favoriteListNavigationVC = UINavigationController(rootViewController: secondVC)
        
        firstVC?.viewModel?.addMovieHandler = { [weak secondVC] in
            secondVC?.viewModel?.addMovies($0)
        }
        
        movieListNavigationVC.setupNavigationBarCustomStyle()
        favoriteListNavigationVC.setupNavigationBarCustomStyle()
        tabBarController.setupTabBarCustomStyle()
        
        tabBarController.setViewControllers([movieListNavigationVC, favoriteListNavigationVC].compactMap { $0 }, animated: true)
        
        return tabBarController
    }
    
    static func movieListController(
        networkController: NetworkControllerProtocol,
        imageDownloader: ImageDownloaderProtocol
    ) -> MovieListViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(
            withIdentifier: Constants.movieListStorybordID
        ) as? MovieListViewController
        let viewModel = MovieListViewModel(networkController: networkController)
        
        viewController?.viewModel = viewModel
        viewController?.lifeCycle = viewModel
        viewController?.imageDownloader = imageDownloader
        viewController?.view.backgroundColor = Constants.backgroundColor
        viewController?.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "list.dash"), tag: 0)
        viewController?.title = NSLocalizedString("Movies list", comment: "")
        return viewController
    }
    
    static func favoriteListController(imageDownloader: ImageDownloaderProtocol) -> FavoriteListViewController {
        let viewController = FavoriteListViewController()
        let viewModel = FavoriteListViewModel()
        
        viewController.viewModel = viewModel
        viewController.imageDownloader = imageDownloader
        viewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "heart.fill"), tag: 1)
        viewController.title = NSLocalizedString("Favorites", comment: "")
        return viewController
    }
    
    static func createMovieDetailController(
        movieResults: MovieResults,
        imageDownloader: ImageDownloaderProtocol
    ) -> UIViewController {
        let viewController = MovieDetailViewController()
        let viewModel = MovieDetailViewModel(movieResults: movieResults, imageDownloader: imageDownloader)
        viewController.viewModel = viewModel
        viewController.lifeCycleModel = viewModel
        return viewController
    }
    
    static func createFavoriteMovieDetailController(
        movieResults: MovieResults,
        imageDownloader: ImageDownloaderProtocol
    ) -> UIViewController {
        let viewController = FavoriteMovieDetailViewController()
        let viewModel = MovieDetailViewModel(movieResults: movieResults, imageDownloader: imageDownloader)
        viewController.viewModel = viewModel
        viewController.lifeCycleModel = viewModel
        return viewController
    }
}
