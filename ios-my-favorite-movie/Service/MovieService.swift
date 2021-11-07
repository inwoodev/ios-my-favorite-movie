//
//  MovieService.swift
//  ios-my-favorite-movie
//
//  Created by 황인우 on 2021/11/01.
//

import Foundation

final class MovieService: MovieServiceProtocol {
    private let movieRepository: MovieRepositoryProtocol
    
    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }
    
    func convertDataToSearchResult(using queryValue: String, completion: @escaping(Result<SearchMovieResult, DataError>) -> Void) {
        let queryURL = MovieServerAPI.movieList.makeURL(queryValue)
        movieRepository.connectToNetwork(purpose: .get, with: queryURL) { result in
            switch result {
            case .failure(let networkError):
                NSLog(networkError.description)
            case .success(let data):
                guard let searchMovieResult = try? JSONDecoder().decode(SearchMovieResult.self, from: data) else {
                    NSLog("Movie Service: \(DataError.unableToDecode)")
                    completion(.failure(.unableToDecode))
                    return
                }
                completion(.success(searchMovieResult))
            }
        }
    }
}
