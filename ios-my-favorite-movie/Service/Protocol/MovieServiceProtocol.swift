//
//  MovieServiceProtocol.swift
//  ios-my-favorite-movie
//
//  Created by 황인우 on 2021/11/04.
//

import Foundation

protocol MovieServiceProtocol {
    func convertDataToSearchResult(using queryValue: String, completion: @escaping(Result<SearchMovieResult, DataError>) -> Void)
}
