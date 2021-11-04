//
//  MovieTableViewCellModel.swift
//  ios-my-favorite-movie
//
//  Created by 황인우 on 2021/11/02.
//

import UIKit

enum MovieCellViewModelStates {
    case empty
    case update(MovieTableViewCellModel.MetaData)
    case error(MovieCellViewModelError)
}

enum MovieCellViewModelError: Error {
    case emptyPath
    case emptyImage
}

final class MovieTableViewCellModel {
    struct MetaData {
        let title: String
        var image: UIImage?
        let director: String
        let actors: String
        let userRating: String
    }
    private (set) var cellState: Observable<MovieCellViewModelStates> = Observable(.empty)
    private let movie: Movie
    private let movieImageService: MovieImageServiceProtocol
    
    init(movie: Movie, movieImageService: MovieImageServiceProtocol) {
        self.movie = movie
        self.movieImageService = movieImageService
    }
    
    convenience init(movie: Movie) {
        let movieImageRepository = MovieImageRepository()
        self.init(movie: movie, movieImageService: MovieImageService(movieImageRepository: movieImageRepository))
    }
    
    func fire() {
        updateText()
        handleImage()
    }
    
    func handleImage() {
        guard let imageURL = try? movie.image.convertToURL() else { return }
        
        movieImageService.loadDownloadedImage(imageURL) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.cellState.value = .error(.emptyImage)
                NSLog(error.description)
            case .success(let image):
                guard case var .update(metaData) = self?.cellState.value else { return }
                metaData.image = image
                
                self?.cellState.value = .update(metaData)
            }
        }
    }
    
    func updateText() {
        guard let movieTitle = movie.title.htmlToString(),
              let movieDirector = movie.director.htmlToString(),
              let movieActors = movie.actor.htmlToString(),
              let userRating = movie.userRating.htmlToString()
        else { return }
        
        let metaData = MetaData(title: movieTitle, image: nil, director: movieDirector, actors: movieActors, userRating: userRating)
        
        cellState.value = .update(metaData)
    }
    
}
