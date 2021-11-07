//
//  StubMovieData.swift
//  ios-my-favorite-movieTests
//
//  Created by 황인우 on 2021/11/08.
//

import Foundation
@testable import ios_my_favorite_movie
struct StubMovieData {
    static let firstStubMovie = Movie(title: "해리포터와 죽음의 성물 -1부", link: "https://m.search.naver.com/search.naver?sm=tab_hty.top&where=nexearch&query=해리+포터와+죽음의+성물+-+1부&x_csa=%7B%22mv_id%22%3A%2247528%22%7D&pkid=68", image: "stubImage.com", subtitle: "stubTitle", pubDate: "stubPubDate", director: "데이빗 예이츠", actor: "다니엘 래드클리프", userRating: "9.32")
    
    static let secondStubMovie = Movie(title: "해리포터와 죽음의 성물 -2부", link: "https://m.search.naver.com/search.naver?sm=tab_hty.top&where=nexearch&query=해리+포터와+죽음의+성물+-+2부&x_csa=%7B%22mv_id%22%3A%2247528%22%7D&pkid=68", image: "stubImage2.com", subtitle: "stubTitle2", pubDate: "stubPubDate2", director: "데이빗 예이츠", actor: "다니엘 래드클리프", userRating: "9.31")
}
