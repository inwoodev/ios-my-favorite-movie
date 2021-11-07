//
//  MovieRemoveDelegate.swift
//  ios-my-favorite-movie
//
//  Created by 황인우 on 2021/11/06.
//

import Foundation

protocol MovieRemoveDelegate: AnyObject {
    func removeUncheckedMovie(using title: String)
}
