//
//  MockURLSession.swift
//  ios-my-favorite-movieTests
//
//  Created by 황인우 on 2021/11/07.
//

import Foundation
@testable import ios_my_favorite_movie
final class MockURLSession: URLSessionProtocol {
    
    private var buildRequestFail: Bool = false
    
    private var mockURLSessionDataTask: MockURLSessionDataTask?
    
    init(buildRequestFail: Bool = false) {
        self.buildRequestFail = buildRequestFail
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        guard let url = request.url else {
            completionHandler(nil, nil, NetworkError.invalidURL)
            return URLSessionDataTask()
        }
        
        let successfulResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "1", headerFields: nil)
        let failureResponse = HTTPURLResponse(url: url, statusCode: 400, httpVersion: "2", headerFields: nil)
        
        mockURLSessionDataTask = MockURLSessionDataTask()
        let invalidRequestError =  NetworkError.invalidRequest
        
        let stubMovie = Movie(title: "해리포터와 죽음의 성물 -2부", link: "https://m.search.naver.com/search.naver?sm=tab_hty.top&where=nexearch&query=해리+포터와+죽음의+성물+-+2부&x_csa=%7B%22mv_id%22%3A%2247528%22%7D&pkid=68", image: "stubImage.com", subtitle: "stubTitle", pubDate: "stubPubDate", director: "데이빗 예이츠", actor: "다니엘 래드클리프", userRating: "9.32")
        
        guard let stubMovieData = try? JSONEncoder().encode(stubMovie) else { return URLSessionDataTask() }
        
        mockURLSessionDataTask?.resumeDidCall = {
            if self.buildRequestFail {
                completionHandler(nil, failureResponse, invalidRequestError)
            } else {
                completionHandler(stubMovieData, successfulResponse, nil)
            }
        }
        mockURLSessionDataTask?.cancelDidCall = {
            completionHandler(nil, failureResponse, invalidRequestError)
        }
        return mockURLSessionDataTask ?? URLSessionDataTask()
        
    }
}
