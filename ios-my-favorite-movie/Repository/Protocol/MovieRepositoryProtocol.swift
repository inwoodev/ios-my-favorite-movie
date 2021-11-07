//
//  MovieRepositoryProtocol.swift
//  ios-my-favorite-movie
//
//  Created by 황인우 on 2021/11/03.
//

import Foundation

protocol MovieRepositoryProtocol {
    func connectToNetwork(purpose httpMethod: HTTPMethod, with url: URL, completion: @escaping (Result <Data, NetworkError>) -> Void)
}
