//
//  MockURLSessionDataTask.swift
//  ios-my-favorite-movieTests
//
//  Created by 황인우 on 2021/11/07.
//

import Foundation
@testable import ios_my_favorite_movie

final class MockURLSessionDataTask: URLSessionDataTask {
    override init() { }
    var resumeDidCall: () -> Void = { }
    var cancelDidCall: () -> Void = { }
    
    override func resume() {
        resumeDidCall()
    }
    
    override func cancel() {
        cancelDidCall()
    }
}
