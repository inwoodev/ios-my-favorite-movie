//
//  NetworkError.swift
//  ios-my-favorite-movie
//
//  Created by 황인우 on 2021/11/01.
//

import Foundation

enum NetworkError: Error, CustomStringConvertible {
    case invalidRequest
    case invalidData
    case identificationFailure
    case invalidURL
    case incorrectQueryRequest
    case invalidDisplayValue
    case invalidStartValue
    case invalidSortValue
    case malformedEncoding
    case invalidSearchAPI
    case systemError
    case serverError
    
    var description: String {
        switch self {
        case .invalidData:
            return "잘못된 데이터입니다."
        case .invalidRequest:
            return "잘못된 요청입니다."
        case .identificationFailure:
            return "클라이언트 아이디 또는 클라이언트 시크릿이 잘못되었습니다."
        case .invalidURL:
            return "잘못된 URL입니다."
        case .incorrectQueryRequest:
            return "잘못된 쿼리 요청입니다."
        case .invalidDisplayValue:
            return "부적절한 display 값입니다."
        case .invalidStartValue:
            return "부적절한 start 값입니다."
        case .invalidSortValue:
            return "부적절한 sort 값입니다."
        case .malformedEncoding:
            return "잘못된 형식의 인코딩입니다."
        case .invalidSearchAPI:
            return "존재하지 않는 검색 api 입니다."
        case .systemError:
            return "시스템에러"
        case .serverError:
            return "서버오류"
        }
    }
}
