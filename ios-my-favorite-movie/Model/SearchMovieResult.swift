//
//  SearchMovieResult.swift
//  ios-my-favorite-movie
//
//  Created by 황인우 on 2021/11/02.
//

import Foundation

struct SearchMovieResult: Codable {
    let lastBuildDate: String
    let total: Int
    let start: Int
    let display: Int
    let items: [Movie]
}
