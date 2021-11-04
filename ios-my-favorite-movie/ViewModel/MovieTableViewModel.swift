//
//  MovieTableViewModel.swift
//  ios-my-favorite-movie
//
//  Created by 황인우 on 2021/11/02.
//

import UIKit

final class MovieTableViewModel {
    private let movieService: MovieServiceProtocol
    
    private (set) var movieInformation: Observable<[Movie]> = Observable([])
    
    init(movieService: MovieServiceProtocol) {
        self.movieService = movieService
    }
    
    convenience init() {
        let movieRepository = MovieRepository(requestFactory: RequestFactory())
        
        self.init(movieService: MovieService(movieRepository: movieRepository))
    }
    
    func handleSearchInput(_ queryValue: String) {
        
        movieService.convertDataToSearchResult(using: queryValue, completion: { [weak self] result in
            
            switch result {
            case .failure(let dataError):
                NSLog(dataError.description)
            case .success(let searchMovieResult):
                self?.movieInformation.value? = searchMovieResult.items
            }
        })
    }
}
