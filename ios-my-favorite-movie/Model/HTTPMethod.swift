//
//  HTTPMethod.swift
//  ios-my-favorite-movie
//
//  Created by 황인우 on 2021/11/03.
//

import Foundation

enum HTTPMethod: CustomStringConvertible {
    case get, post, patch, delete
    
    var description: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .patch:
            return "PATCH"
        case .delete:
            return "DELETE"
        }
    }
}
