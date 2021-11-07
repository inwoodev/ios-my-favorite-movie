//
//  MovieURL.swift
//  ios-my-favorite-movie
//
//  Created by 황인우 on 2021/11/01.
//

import Foundation

enum MovieServerAPI {
    case movieList
    
    func makeURL(_ queryValue: String) -> URL {
        switch self {
        case .movieList:
            guard let encodedQuery = "https://openapi.naver.com/v1/search/movie.json?query=\(queryValue)".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed),
                  let queryURL = URL(string: encodedQuery)
                  
            else {
                return URL(fileURLWithPath: "")
            }
            return queryURL
        }
    }
}
