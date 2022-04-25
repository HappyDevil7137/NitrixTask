//
//  UICollectionView+Extension.swift
//  MovieList_I.Stakankov
//
//  Created by Golos on 24.04.2022.
//

import UIKit

extension UICollectionView {
    func registerCellWithNib<T: UICollectionViewCell>(_: T.Type) {
        let nib = UINib(nibName: T.nibName, bundle: .main)
        register(nib, forCellWithReuseIdentifier: String(describing: T.self))
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError()
        }
        return cell
    }
}
