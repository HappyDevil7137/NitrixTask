//
//  MovieCell.swift
//  MovieList_I.Stakankov
//
//  Created by Golos on 22.04.2022.
//

import UIKit

final class MovieCell: UITableViewCell {
    private enum Constants {
        static let defaultOffset: CGFloat = 15
        static let numberOflines: Int = 3
        static let posterSize: CGFloat = 70
        static let textColor: UIColor = .systemOrange
        static let titleFont: UIFont = .systemFont(ofSize: 17, weight: .semibold)
        static let descriptionFont: UIFont = .systemFont(ofSize: 12, weight: .regular)
        static let placeholder = UIImage(named: "placeholder")
    }
    
    private let moviePoster = UIImageView()
    private let movieTitle = UILabel()
    private let movieDescription = UILabel()
    
    var imageDownloader: ImageDownloaderProtocol?
    
    var titleText: String? {
        didSet {
            movieTitle.text = titleText
        }
    }
    
    var posterURL: String? {
        didSet {
            imageDownloader?.downloadImage(
                from: .imageName(posterURL ?? ""),
                for: moviePoster,
                placeholder: Constants.placeholder
            )
        }
    }
    
    var descriptionText: String? {
        didSet {
            movieDescription.text = descriptionText
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        addSubviews([moviePoster, movieTitle, movieDescription])
        setupPoster()
        setupTitle()
        setupDescription()
    }
    
    private func setupPoster() {
        moviePoster.contentMode = .scaleAspectFill
        moviePoster.layer.cornerRadius = Constants.posterSize / 2
        moviePoster.clipsToBounds = true
        moviePoster.image = Constants.placeholder
        
        NSLayoutConstraint.activate([
            moviePoster.topAnchor.constraint(equalTo: topAnchor, constant: Constants.defaultOffset),
            moviePoster.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.defaultOffset),
            moviePoster.widthAnchor.constraint(equalToConstant: Constants.posterSize),
            moviePoster.heightAnchor.constraint(equalToConstant: Constants.posterSize)
        ])
    }
    
    private func setupTitle() {
        movieTitle.font = Constants.titleFont
        movieTitle.textColor = Constants.textColor
        
        NSLayoutConstraint.activate([
            movieTitle.topAnchor.constraint(equalTo: topAnchor, constant: Constants.defaultOffset),
            movieTitle.leadingAnchor.constraint(equalTo: moviePoster.trailingAnchor, constant: Constants.defaultOffset),
            movieTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.defaultOffset)
        ])
    }
    
    private func setupDescription() {
        movieDescription.numberOfLines = Constants.numberOflines
        movieDescription.font = Constants.descriptionFont
        movieDescription.textColor = Constants.textColor
        
        NSLayoutConstraint.activate([
            movieDescription.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: Constants.defaultOffset),
            movieDescription.leadingAnchor.constraint(equalTo: moviePoster.trailingAnchor, constant: Constants.defaultOffset),
            movieDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.defaultOffset),
            movieDescription.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.defaultOffset)
        ])
    }
}
