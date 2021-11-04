//
//  MovieImageServiceProtocol.swift
//  ios-my-favorite-movie
//
//  Created by 황인우 on 2021/11/04.
//

import UIKit

protocol MovieImageServiceProtocol {
    func loadDownloadedImage(_ url: URL, completion: @escaping ( Result <UIImage, NetworkError>) -> Void)
}
