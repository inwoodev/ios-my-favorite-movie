//
//  MetaData.swift
//  ios-my-favorite-movie
//
//  Created by 황인우 on 2021/11/05.
//

import UIKit

struct MetaData: Equatable {
    let title: String
    let link: String
    let image: String
    let director: String
    let actor: String
    let userRating: String
    var favoriteStatus: FavoriteStatus
}

struct ContentMetaData {
    let title: String
    var image: UIImage?
    let director: String
    let actors: String
    let userRating: String
    let link: URL
}

enum FavoriteStatus {
    case initial, checked, unchecked
}
