//
//  FavoriteListViewController.swift
//  MovieList_I.Stakankov
//
//  Created by Golos on 22.04.2022.
//

import UIKit
import SnapKit

final class FavoriteListViewController: UIViewController {
    private enum Constants {
        static let tintColor: UIColor = .systemRed
    }
    
    private lazy var deleteButton = UIBarButtonItem(
        title: NSLocalizedString("Delete", comment: ""),
        style: .plain,
        target: self,
        action: #selector(deleteMovies)
    )
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .gridLayout)
    
    var viewModel: FavoriteListViewModelProtocol?
    var imageDownloader: ImageDownloaderProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItems = [editButtonItem]
        
        deleteButton.tintColor = Constants.tintColor
        createCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        navigationItem.rightBarButtonItems = !editing ? [editButtonItem] : [editButtonItem, deleteButton]
        
        collectionView.allowsMultipleSelection = editing
        collectionView.indexPathsForSelectedItems?.forEach { indexPath in
            collectionView.deselectItem(at: indexPath, animated: false)
        }
        collectionView.indexPathsForVisibleItems.forEach { indexPath in
            let cell = collectionView.cellForItem(at: indexPath) as? FavoriteCollectionViewCell
            cell?.isEditing = editing
        }
    }
    
    @objc private func deleteMovies() {
        if let selectedItems = collectionView.indexPathsForSelectedItems {
            viewModel?.deleteMovies(for: selectedItems)
            collectionView.deleteItems(at: selectedItems)
        }
    }
    
    private func createCollectionView() {
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.registerCellWithNib(FavoriteCollectionViewCell.self)
        
        collectionView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension FavoriteListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.dataArray.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FavoriteCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let result = viewModel?.dataArray.element(at: indexPath.row)
        cell.imageDownloader = imageDownloader
        cell.titleText = result?.title
        cell.posterURL = result?.posterPath
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard !isEditing,
              let movie = viewModel?.dataArray.element(at: indexPath.row),
              let imageDownloader = imageDownloader
        else { return }
        let movieDetailViewController = ControllersFactory.createFavoriteMovieDetailController(
            movieResults: movie,
            imageDownloader: imageDownloader
        )
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}
