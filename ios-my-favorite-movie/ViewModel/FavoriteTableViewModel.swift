//
//  FavoriteMovieTableViewModel.swift
//  ios-my-favorite-movie
//
//  Created by 황인우 on 2021/11/04.
//

import Foundation

final class FavoriteMovieTableViewModel {
    weak var delegate: FavoriteMovieStatusDetactable?
    private (set) var favoriteList: Observable<[MetaData]> = Observable([])
    
    func removeUnfavoriteMovie(cheking title: String) {
        let filteredList = favoriteList.value?.filter { $0.title != title }
        favoriteList.value = filteredList
    }
    
    func addFavoriteMovie(selectedMovie: MetaData) {
        guard let favoriteMovieList = favoriteList.value else { return }
        
        if !favoriteMovieList.contains(where: {
            $0.title == selectedMovie.title
        }) {
            favoriteList.value?.append(selectedMovie)
        }
    }
    func notifyDeletedFavoriteMovies(using title: String) {
        delegate?.detectChangeOfFavoriteMovieStatus(checking: title)
        self.removeUnfavoriteMovie(cheking: title)
    }
}
