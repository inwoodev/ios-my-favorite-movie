//
//  MovieTableViewModel.swift
//  ios-my-favorite-movie
//
//  Created by 황인우 on 2021/11/02.
//

import UIKit

final class MovieTableViewModel {
    private let movieService: MovieServiceProtocol
    
    private (set) var movieInformation: Observable<[MetaData]> = Observable([])
    
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
                let movieInformation = searchMovieResult.items
                let metaData = movieInformation.compactMap { MetaData(title: $0.title, link: $0.link, image: $0.image, director: $0.director, actor: $0.actor, userRating: $0.userRating, favoriteStatus: .initial) }
                self?.movieInformation.value? = metaData
            }
        })
    }
    
    func handleFavoriteMovieStatus(of index: Int) {
        guard let favoriteMovieStatus = self.movieInformation.value?[index].favoriteStatus else { return }
        switch favoriteMovieStatus {
        case .initial:
            self.movieInformation.value?[index].favoriteStatus = .checked
        case .checked:
            self.movieInformation.value?[index].favoriteStatus = .unchecked
        case .unchecked:
            self.movieInformation.value?[index].favoriteStatus = .checked
        }
    }
}

extension MovieTableViewModel: FavoriteMovieStatusDetactable {
    func detectChangeOfFavoriteMovieStatus(checking title: String) {
        guard var movieDataList = movieInformation.value else { return }
        
        for metaData in movieDataList.indices where movieDataList[metaData].title == title {
            movieDataList[metaData].favoriteStatus = .unchecked
        }
        self.movieInformation.value = movieDataList
    }
}
