//
//  MovieTableViewCellModel.swift
//  ios-my-favorite-movie
//
//  Created by 황인우 on 2021/11/02.
//

import UIKit

enum MovieCellViewModelStates {
    case empty
    case update(ContentMetaData)
    case error(MovieCellViewModelError)
}

enum MovieCellViewModelError: Error {
    case emptyPath
    case emptyImage
}

enum FavoriteButtonState {
    case checked
    case unchecked
}

final class MovieTableViewCellModel {
    private (set) var cellState: Observable<MovieCellViewModelStates> = Observable(.empty)
    private (set) var favoriteButtonState: Observable<FavoriteButtonState>
    private (set) var cellIndex: Int
    
    private let metaData: MetaData
    private let movieImageService: MovieImageServiceProtocol
    
    init(metaData: MetaData, movieImageService: MovieImageServiceProtocol, cellIndex: Int, favoriteButtonState: Observable<FavoriteButtonState>) {
        self.metaData = metaData
        self.movieImageService = movieImageService
        self.cellIndex = cellIndex
        self.favoriteButtonState = favoriteButtonState
    }
    
    convenience init(metaData: MetaData, cellIndex: Int, favoriteButtonState: Observable<FavoriteButtonState>) {
        let movieImageRepository = MovieImageRepository()
        self.init(metaData: metaData, movieImageService: MovieImageService(movieImageRepository: movieImageRepository), cellIndex: cellIndex, favoriteButtonState: favoriteButtonState)
    }
    
    func fire() {
        updateText()
        handleImage()
    }
    
    func handleImage() {
        guard let imageURL = try? metaData.image.convertToURL() else { return }
        
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
        guard let movieTitle = metaData.title.htmlToString(),
              let movieDirector = metaData.director.htmlToString(),
              let movieActors = metaData.actor.htmlToString(),
              let userRating = metaData.userRating.htmlToString(),
              let movieSiteLink = try? metaData.link.convertToURL()
        else { return }
        
        let contentMetaData = ContentMetaData(title: movieTitle, image: nil, director: movieDirector, actors: movieActors, userRating: userRating, link: movieSiteLink)
        
        cellState.value = .update(contentMetaData)
    }
}
