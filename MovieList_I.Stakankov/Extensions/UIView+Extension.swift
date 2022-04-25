//
//  UIView+Extension.swift
//  MovieList_I.Stakankov
//
//  Created by Golos on 24.04.2022.
//

import UIKit

extension UIView {
    
    static var nibName: String {
        "\(self)".components(separatedBy: ".").first ?? ""
    }
    
    func addSubviews(_ views: [UIView]) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
}
