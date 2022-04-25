//
//  ImageDowndloder.swift
//  MovieList_I.Stakankov
//
//  Created by Golos on 25.04.2022.
//

import Kingfisher
import UIKit

protocol ImageDownloaderProtocol {
    func downloadImage(from source: ImageDownloader.Source, completion: @escaping (UIImage?) -> Void)
    func downloadImage(from source: ImageDownloader.Source, for imageView: UIImageView, placeholder: UIImage?)
}

final class ImageDownloader: ImageDownloaderProtocol {
    enum Source {
        case url(URL)
        case imageName(String)
    }
    
    private let baseURL: String
    private let manager: KingfisherManager
    
    init(baseURL: String, manager: KingfisherManager = .shared) {
        self.baseURL = baseURL
        self.manager = manager
    }
    
    func downloadImage(from source: Source, completion: @escaping (UIImage?) -> Void) {
        guard let imageURL = retriveBaseURL(source: source) else { return }
        
        manager.retrieveImage(with: imageURL) {
            switch $0 {
            case let .success(result):
                completion(result.image)
            case .failure:
                completion(nil)
            }
        }
    }
    
    func downloadImage(from source: Source, for imageView: UIImageView, placeholder: UIImage?) {
        guard let imageURL = retriveBaseURL(source: source) else { return }
        imageView.kf.setImage(with: imageURL, placeholder: placeholder)
    }
    
    private func retriveBaseURL(source: Source) -> URL? {
        switch source {
        case let .url(value): return value
        case let .imageName(value): return URL(string: baseURL + value)
        }
    }
}
