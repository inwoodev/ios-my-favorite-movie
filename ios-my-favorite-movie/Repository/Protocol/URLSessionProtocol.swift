//
//  URLSessionProtocol.swift
//  ios-my-favorite-movie
//
//  Created by 황인우 on 2021/11/07.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }
