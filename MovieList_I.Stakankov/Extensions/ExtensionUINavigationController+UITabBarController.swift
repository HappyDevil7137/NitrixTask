//
//  ExtensionUINavigationController+UITabBarController.swift
//  MovieList_I.Stakankov
//
//  Created by Golos on 22.04.2022.
//

import UIKit

private enum StyleConstants {
    static let borderWidth: CGFloat = 0.7
    static let cornerRadius: CGFloat = 20
    static let borderColor: CGColor = .init(red: 255, green: 140, blue: 0, alpha: 1)
    static let tintColor: UIColor = .systemOrange
}

extension UINavigationController {
    
    func setupNavigationBarCustomStyle() {
        navigationBar.layer.borderWidth = StyleConstants.borderWidth
        navigationBar.layer.borderColor = StyleConstants.borderColor
        navigationBar.layer.cornerRadius = StyleConstants.cornerRadius
        
        let navigationColoredAppearance = UINavigationBarAppearance()
        navigationColoredAppearance.configureWithTransparentBackground()
        navigationColoredAppearance.titleTextAttributes = [.foregroundColor: StyleConstants.tintColor]
        navigationColoredAppearance.largeTitleTextAttributes = [.foregroundColor: StyleConstants.tintColor]
        navigationColoredAppearance.backgroundColor = .black
        
        UINavigationBar.appearance().compactAppearance = navigationColoredAppearance
        UINavigationBar.appearance().standardAppearance = navigationColoredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationColoredAppearance
        UINavigationBar.appearance().tintColor = StyleConstants.tintColor
    }
}

extension UITabBarController {
    
    func setupTabBarCustomStyle() {
        tabBar.tintColor = StyleConstants.tintColor
        tabBar.unselectedItemTintColor = .white
        
        let tabBarColoredAppearance = UITabBarAppearance()
        tabBarColoredAppearance.configureWithTransparentBackground()
        tabBarColoredAppearance.backgroundColor = .black
        tabBar.standardAppearance = tabBarColoredAppearance
        tabBar.scrollEdgeAppearance = tabBarColoredAppearance
    }
}

