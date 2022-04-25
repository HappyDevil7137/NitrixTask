//
//  Array+Extension.swift
//  MovieList_I.Stakankov
//
//  Created by Golos on 24.04.2022.
//

import Foundation

extension Array {
    func element(at index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
