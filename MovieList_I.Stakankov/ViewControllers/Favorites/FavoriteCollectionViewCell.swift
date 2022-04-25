//
//  FavoriteCollectionViewCell.swift
//  MovieList_I.Stakankov
//
//  Created by Golos on 22.04.2022.
//

import UIKit

final class FavoriteCollectionViewCell: UICollectionViewCell {
    private enum Constants {
        static let titleFont: UIFont = .systemFont(ofSize: 17, weight: .semibold)
        static let selectLabelFont: UIFont = .systemFont(ofSize: 40, weight: .semibold)
        static let textColor: UIColor = .systemOrange
        static let selectLabelColor: UIColor = .systemRed
        static let placeholder = UIImage(named: "placeholder")
    }

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var selectLabel: UILabel!
    
    var imageDownloader: ImageDownloaderProtocol?
    
    var isEditing: Bool = false {
        didSet {
            selectLabel.isHidden = !isEditing
        }
    }
    
    var titleText: String? {
        didSet {
            movieTitle.text = titleText
        }
    }
    
    var posterURL: String? {
        didSet {
            imageDownloader?.downloadImage(
                from: .imageName(posterURL ?? ""),
                for: posterImage,
                placeholder: Constants.placeholder
            )
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isEditing {
                selectLabel.text = isSelected ? "✓" : ""
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupSelectLabel()
        setupPoster()
        setupTitle()
    }
    
    private func setupPoster() {
        posterImage.contentMode = .scaleAspectFill
        posterImage.layer.cornerRadius = posterImage.frame.width / 2
        posterImage.clipsToBounds = true
        posterImage.image = Constants.placeholder
    }
    
    private func setupTitle() {
        movieTitle.font = Constants.titleFont
        movieTitle.textColor = Constants.textColor
        movieTitle.numberOfLines = .zero
        movieTitle.textAlignment = .center
    }
    
    private func setupSelectLabel() {
        selectLabel.font = Constants.selectLabelFont
        selectLabel.textColor = Constants.selectLabelColor
        selectLabel.text = ""
    }
}
