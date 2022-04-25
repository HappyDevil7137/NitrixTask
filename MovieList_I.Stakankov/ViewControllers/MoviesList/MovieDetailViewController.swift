//
//  MovieDetailViewController.swift
//  MovieList_I.Stakankov
//
//  Created by Golos on 22.04.2022.
//

import UIKit
import SnapKit

final class MovieDetailViewController: UIViewController {
    private enum Constants {
        static let titleFont: UIFont = .systemFont(ofSize: 25, weight: .semibold)
        static let descriptionFont: UIFont = .systemFont(ofSize: 17, weight: .regular)
        static let textColor: UIColor = .systemOrange
        static let backgroundColor: UIColor = .black
        static let posterSize: CGFloat = 200
        static let posterTopOffset: CGFloat = 30
        static let textOffset: CGFloat = 20
        static let dateTopOffset: CGFloat = 10
        static let placeholder = UIImage(named: "placeholder")
    }
    
    private let moviePoster = UIImageView()
    private let movieTitle = UILabel()
    private let movieDescription = UILabel()
    private let releaseDate = UILabel()
    
    var viewModel: MovieDetailViewModelProtocol?
    var lifeCycleModel: ViewLifecycleModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        setupView()
        
        viewModel?.movieHandler = { [weak self] in
            self?.movieTitle.text = $0.title
            self?.movieDescription.text = $0.overview
            self?.releaseDate.text = String(format: NSLocalizedString("Release date: %@", comment: ""), $0.releaseDate)
        }
        viewModel?.posterHandler = { [weak self] in
            self?.moviePoster.image = $0 ?? Constants.placeholder
        }
        
        lifeCycleModel?.viewDidLoaded()
    }
    
    private func setupView() {
        view.addSubviews([moviePoster, movieTitle, movieDescription, releaseDate])
        setupPoster()
        setupTitle()
        setupDescription()
        setupDate()
    }
    
    private func setupPoster() {
        moviePoster.contentMode = .scaleAspectFill
        moviePoster.layer.cornerRadius = Constants.posterSize / 2
        moviePoster.clipsToBounds = true
        moviePoster.image = Constants.placeholder
        
        moviePoster.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Constants.posterTopOffset)
            $0.size.equalTo(Constants.posterSize)
        }
    }
    
    private func setupTitle() {
        movieTitle.font = Constants.titleFont
        movieTitle.textColor = Constants.textColor
        movieTitle.textAlignment = .center
        
        movieTitle.snp.makeConstraints {
            $0.top.equalTo(moviePoster.snp.bottom).offset(Constants.textOffset)
            $0.trailing.equalToSuperview().offset(-Constants.textOffset)
            $0.leading.equalToSuperview().offset(Constants.textOffset)
        }
    }
    
    private func setupDate() {
        releaseDate.font = Constants.descriptionFont
        releaseDate.textColor = Constants.textColor
        releaseDate.textAlignment = .center
        
        releaseDate.snp.makeConstraints {
            $0.top.equalTo(movieTitle.snp.bottom).offset(Constants.dateTopOffset)
            $0.trailing.equalToSuperview().offset(-Constants.textOffset)
            $0.leading.equalToSuperview().offset(Constants.textOffset)
        }
    }
    
    private func setupDescription() {
        movieDescription.font = Constants.descriptionFont
        movieDescription.textColor = Constants.textColor
        movieDescription.numberOfLines = .zero
        
        movieDescription.snp.makeConstraints {
            $0.top.equalTo(releaseDate.snp.bottom).offset(Constants.textOffset)
            $0.trailing.equalToSuperview().offset(-Constants.textOffset)
            $0.leading.equalToSuperview().offset(Constants.textOffset)
        }
    }
}
