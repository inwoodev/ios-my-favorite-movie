//
//  FavoriteMovieStatusDetactable.swift
//  ios-my-favorite-movie
//
//  Created by 황인우 on 2021/11/07.
//

import Foundation

protocol FavoriteMovieStatusDetactable: AnyObject {
    func detectChangeOfFavoriteMovieStatus(checking title: String)
}
