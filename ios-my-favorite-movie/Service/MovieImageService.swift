//
//  MovieImageService.swift
//  ios-my-favorite-movie
//
//  Created by 황인우 on 2021/11/04.
//

import UIKit

final class MovieImageService: MovieImageServiceProtocol {
    private let movieImageRepository: MovieImageRepositoryProtocol
    
    init(movieImageRepository: MovieImageRepositoryProtocol) {
        self.movieImageRepository = movieImageRepository
    }
    
    func loadDownloadedImage(_ url: URL, completion: @escaping ( Result <UIImage, NetworkError>) -> Void) {
        movieImageRepository.downloadImage(from: url) { image, _ in
            guard let validImage = image else {
                completion(.failure(.invalidData))
                return
                
            }
            completion(.success(validImage))
        }
    }
}
