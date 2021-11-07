//
//  MovieImageRepositoryProtocol.swift
//  ios-my-favorite-movie
//
//  Created by 황인우 on 2021/11/04.
//

import UIKit

protocol MovieImageRepositoryProtocol {
    func downloadImage(from url: URL, completion: @escaping(UIImage?, Error?) -> Void
    )
}
