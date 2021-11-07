//
//  FavoriteMovieTableViewCellModel.swift
//  ios-my-favorite-movie
//
//  Created by 황인우 on 2021/11/05.
//

import Foundation

enum FavoriteMoviePageButtonState {
    case initial
    case checked(ContentMetaData)
    case unchecked
}

final class FavoriteMovieTableViewCellModel {
    private (set) var favoriteButtonState: Observable< FavoriteMoviePageButtonState> = Observable(.initial)
    private (set) var cellIndex: Int
    
    private let metaData: MetaData
    private let movieImageService: MovieImageServiceProtocol
    
    init(metaData: MetaData, movieImageService: MovieImageServiceProtocol, cellIndex: Int) {
        self.metaData = metaData
        self.movieImageService = movieImageService
        self.cellIndex = cellIndex
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
                NSLog(error.description)
            case .success(let image):
                guard case var .checked(metaData) = self?.favoriteButtonState.value else { return }
                metaData.image = image
                
                self?.favoriteButtonState.value = .checked(metaData)
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
        
        favoriteButtonState.value = .checked(contentMetaData)
    }
}
