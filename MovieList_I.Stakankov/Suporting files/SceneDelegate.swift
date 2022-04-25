//
//  SceneDelegate.swift
//  MovieList_I.Stakankov
//
//  Created by Golos on 22.04.2022.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    private lazy var networkController = NetworkController(
        baseURL: "https://api.themoviedb.org",
        apiKey: "f938d9753a0276abd3410b98edf427cc"
    )
    private lazy var imageDownloader = ImageDownloader(baseURL: "https://image.tmdb.org/t/p/w300_and_h450_bestv2")
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: scene)
        window?.rootViewController = ControllersFactory.createTabBarAndNavigation(
            firstVC: ControllersFactory.movieListController(
                networkController: networkController,
                imageDownloader: imageDownloader
            ),
            secondVC: ControllersFactory.favoriteListController(imageDownloader: imageDownloader)
        )
        window?.makeKeyAndVisible()
    }
}
