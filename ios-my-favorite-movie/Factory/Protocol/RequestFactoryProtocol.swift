//
//  RequestFactoryProtocol.swift
//  ios-my-favorite-movie
//
//  Created by 황인우 on 2021/11/03.
//

import Foundation

protocol RequestFactoryProtocol {
    func buildRequestWithClientInformation(httpMethod: HTTPMethod, with url: URL) -> URLRequest
}
