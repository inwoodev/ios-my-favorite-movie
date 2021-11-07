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
        
        let stubSearchMovieResult = SearchMovieResult(lastBuildDate: "stubBuildDate", total: 2, start: 1, display: 2, items: [StubMovieData.firstStubMovie, StubMovieData.secondStubMovie])
        
        guard let stubMovieData = try? JSONEncoder().encode(stubSearchMovieResult) else { return URLSessionDataTask() }
        
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
