//
//  MovieImageRepository.swift
//  ios-my-favorite-movie
//
//  Created by 황인우 on 2021/11/02.
//

import UIKit

final class MovieImageRepository: MovieImageRepositoryProtocol {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func downloadImage(from url: URL, completion: @escaping(UIImage?, Error?) -> Void
    ) {
        urlSession.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
            }
            
            guard let urlResponse = response as? HTTPURLResponse,
                  (200...299).contains(urlResponse.statusCode) else {
                completion(nil, NetworkError.invalidRequest)
                return
            }
            
            guard let validData = data,
                  let image = UIImage(data: validData) else {
                completion(nil, DataError.unableToDecode)
                return
            }
            completion(image, nil)
        }.resume()
    }
}
