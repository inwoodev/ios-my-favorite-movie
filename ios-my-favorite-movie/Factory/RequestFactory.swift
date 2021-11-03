//
//  RequestFactory.swift
//  ios-my-favorite-movie
//
//  Created by 황인우 on 2021/11/01.
//

import Foundation

struct RequestFactory: RequestFactoryProtocol {
    
    enum NaverAPIInformation {
        case clientID, clientSecret
        
        var headerField: String {
            switch self {
            case .clientID:
                return "X-Naver-Client-Id"
            case .clientSecret:
                return "X-Naver-Client-Secret"
            }
        }
        
        var value: String {
            switch self {
            case .clientID:
                return "8k6jj4ZLuNWeznNCT4ED"
            case .clientSecret:
                return "7NxnzvVmlB"
            }
        }
    }
    
    private let contentTypeDescription = "Content-Type"
    private let jsonTypeDescription = "application/json"
    private let utf8CharsetDescription = "charset=utf-8"
    
    func buildRequestWithClientInformation(httpMethod: HTTPMethod, with url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.description
        request.addValue("\(jsonTypeDescription);\(utf8CharsetDescription)", forHTTPHeaderField: contentTypeDescription)
        request.addValue(NaverAPIInformation.clientID.value, forHTTPHeaderField: NaverAPIInformation.clientID.headerField)
        request.addValue(NaverAPIInformation.clientSecret.value, forHTTPHeaderField: NaverAPIInformation.clientSecret.headerField)
        
        return request
    }
}
