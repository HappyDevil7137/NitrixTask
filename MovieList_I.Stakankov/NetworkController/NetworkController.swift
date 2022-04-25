//
//  NetworkController.swift
//  MovieList_I.Stakankov
//
//  Created by Golos on 22.04.2022.
//

import Foundation

protocol NetworkControllerProtocol {
    func getRequest<T: Decodable>( 
        request: ApiRequest<T>,
        completion: @escaping (Result<T, NetworkController.NetworkError>) -> Void
    )
}

final class NetworkController: NetworkControllerProtocol {
    enum NetworkError: Error {
        case parsing
        case unknown(Error?)
    }
    
    private let baseURL: String
    private let apiKey: String
    private let urlSession: URLSession
    private let decoder: JSONDecoder
    
    init(baseURL: String, apiKey: String, urlSession: URLSession = .shared, decoder: JSONDecoder = .init()) {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.urlSession = urlSession
        self.decoder = decoder
    }
    
    func getRequest<T: Decodable>(request: ApiRequest<T>, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let urlString = "\(baseURL)\(request.url)?api_key=\(apiKey)" + request.getParameters.reduce("") {
            $0 + "&\($1.key)=\($1.value)"
        }
        guard let url = URL(string: urlString) else { return }
        urlSession.dataTask(with: url) { [weak self] data, _ ,error in
            guard let data = data else {
                completion(.failure(.unknown(error)))
                return
            }
            guard let result = try? self?.decoder.decode(T.self, from: data) else {
                completion(.failure(.parsing))
                return
            }
            completion(.success(result))
        }
        .resume()
    }
}
