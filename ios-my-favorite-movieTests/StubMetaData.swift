//
//  StubMetaData.swift
//  ios-my-favorite-movieTests
//
//  Created by 황인우 on 2021/11/08.
//

import Foundation
@testable import ios_my_favorite_movie

struct StubMetaData {
    static let firstMovie = MetaData(title: StubMovieData.firstStubMovie.title, link: StubMovieData.firstStubMovie.link, image: StubMovieData.firstStubMovie.image, director: StubMovieData.firstStubMovie.director, actor: StubMovieData.firstStubMovie.actor, userRating: StubMovieData.firstStubMovie.userRating, favoriteStatus: .initial)
    
    static let secondMovie = MetaData(title: StubMovieData.secondStubMovie.title, link: StubMovieData.secondStubMovie.link, image: StubMovieData.secondStubMovie.image, director: StubMovieData.secondStubMovie.director, actor: StubMovieData.secondStubMovie.actor, userRating: StubMovieData.secondStubMovie.userRating, favoriteStatus: .initial)
    
    static let firstMovieMarkedFavorite = MetaData(title: StubMovieData.firstStubMovie.title, link: StubMovieData.firstStubMovie.link, image: StubMovieData.firstStubMovie.image, director: StubMovieData.firstStubMovie.director, actor: StubMovieData.firstStubMovie.actor, userRating: StubMovieData.firstStubMovie.userRating, favoriteStatus: .checked)
    
    static let secondMovieMarkedFavorite = MetaData(title: StubMovieData.secondStubMovie.title, link: StubMovieData.secondStubMovie.link, image: StubMovieData.secondStubMovie.image, director: StubMovieData.secondStubMovie.director, actor: StubMovieData.secondStubMovie.actor, userRating: StubMovieData.secondStubMovie.userRating, favoriteStatus: .checked)
}
