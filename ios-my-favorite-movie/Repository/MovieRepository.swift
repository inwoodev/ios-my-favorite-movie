//
//  MovieRepository.swift
//  ios-my-favorite-movie
//
//  Created by 황인우 on 2021/11/01.
//

import Foundation

final class MovieRepository: MovieRepositoryProtocol {
    private let requestFactory: RequestFactoryProtocol
    private let urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol = URLSession.shared, requestFactory: RequestFactoryProtocol) {
        self.urlSession = urlSession
        self.requestFactory = requestFactory
    }
    
    func connectToNetwork(purpose httpMethod: HTTPMethod, with url: URL, completion: @escaping (Result <Data, NetworkError>) -> Void) {
        let request = requestFactory.buildRequestWithClientInformation(httpMethod: httpMethod, with: url)
        
        // MARK: - Request Log
        
        print("------------")
        NSLog(String(describing: request.allHTTPHeaderFields))
        print("------------")
        NSLog(request.httpMethod ?? "")
        print("------------")
        
        urlSession.dataTask(with: request) { data, response, _ in
            guard let urlResponse = response as? HTTPURLResponse,
                  (200...299).contains(urlResponse.statusCode) else {
                      completion(.failure(.invalidRequest))
                      return
            }
            guard let validData = data else {
                completion(.failure(.invalidData))
                return
            }
            
            completion(.success(validData))
            
        }.resume()
    }
}
