//
//  MovieListViewController.swift
//  MovieList_I.Stakankov
//
//  Created by Golos on 22.04.2022.
//

import UIKit

final class MovieListViewController: UIViewController {
    private enum Constants {
        static let backgroundColor: UIColor = .black
        static let longPressDuration = 0.7
    }

    @IBOutlet private weak var moviesListTableView: UITableView!
    
    var viewModel: MovieListViewProtocol?
    var lifeCycle: ViewLifecycleModel?
    var imageDownloader: ImageDownloaderProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        
        let longPressRecognizer = UILongPressGestureRecognizer(
            target: self,
            action: #selector(longPress)
        )
        longPressRecognizer.minimumPressDuration = Constants.longPressDuration
        
        moviesListTableView.addGestureRecognizer(longPressRecognizer)
        
        setupTableView()
        viewModel?.reloadTableHandler = { [weak self] in
            self?.moviesListTableView.reloadData()
        }
        lifeCycle?.viewDidLoaded()
    }
    
    private func setupTableView() {
        moviesListTableView.registerCell(MovieCell.self)
        moviesListTableView.delegate = self
        moviesListTableView.dataSource = self
        moviesListTableView.backgroundColor = .clear
    }
    
    @objc private func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        guard longPressGestureRecognizer.state == .began else { return }
        let touchPoint = longPressGestureRecognizer.location(in: moviesListTableView)
        
        guard let indexPath = moviesListTableView.indexPathForRow(at: touchPoint) else { return }
        viewModel?.addMovie(with: indexPath.row)
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dataArray.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieCell = moviesListTableView.dequeueReusableCell(for: indexPath)
        guard let result = viewModel?.dataArray.element(at: indexPath.row) else { return .init() }
        cell.imageDownloader = imageDownloader
        cell.titleText = result.title
        cell.descriptionText = result.overview
        cell.posterURL = result.posterPath
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movie = viewModel?.dataArray.element(at: indexPath.row), let imageDownloader = imageDownloader else { return }
        let movieDetailViewController = ControllersFactory.createMovieDetailController(
            movieResults: movie,
            imageDownloader: imageDownloader
        )
        
        navigationController?.pushViewController(movieDetailViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

//MARK: - UIScrollViewDelegate

extension MovieListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            viewModel?.loadData()
        }
    }
}
