//
//  UICollectionViewLayout+Extension.swift
//  MovieList_I.Stakankov
//
//  Created by Golos on 25.04.2022.
//

import UIKit

extension UICollectionViewLayout {
    private enum Constants {
        static let indents: CGFloat = 10
        static let itemIndents: CGFloat = 10
        static let columsCount: Int = 3
        static let fractionalWidth: CGFloat = 1.0
        static let sectionFractionalHeight: CGFloat = 0.25
    }
    
    static var gridLayout: UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Constants.fractionalWidth),
            heightDimension: .fractionalHeight(Constants.fractionalWidth)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: Constants.itemIndents,
            leading: Constants.itemIndents,
            bottom: Constants.itemIndents,
            trailing: Constants.itemIndents
        )
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Constants.fractionalWidth),
            heightDimension: .fractionalHeight(Constants.sectionFractionalHeight)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: Constants.columsCount
        )
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: Constants.indents,
            leading: Constants.indents,
            bottom: Constants.indents,
            trailing: Constants.indents
        )
        return UICollectionViewCompositionalLayout(section: section)
    }
}
