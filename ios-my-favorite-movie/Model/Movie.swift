//
//  Movie.swift
//  ios-my-favorite-movie
//
//  Created by 황인우 on 2021/11/01.
//

import Foundation

struct Movie: Codable {
    let title: String
    let link: String
    let image: String
    let subtitle: String
    let pubDate: String
    let director: String
    let actor: String
    let userRating: String
}
