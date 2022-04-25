//
//  UITableView+Extension.swift
//  MovieList_I.Stakankov
//
//  Created by Golos on 24.04.2022.
//

import UIKit

extension UITableView {
    func registerCell<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: T.self))
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError()
        }
        return cell
    }
}
