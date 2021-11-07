//
//  FavoriteMovieSelectable.swift
//  ios-my-favorite-movie
//
//  Created by 황인우 on 2021/11/05.
//

import Foundation

protocol FavoriteMovieSelectionDelegate: AnyObject {
    func handleFavoriteMovieStatus(at index: Int)
}
