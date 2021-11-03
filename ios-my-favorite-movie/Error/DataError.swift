//
//  DataError.swift
//  ios-my-favorite-movie
//
//  Created by 황인우 on 2021/11/02.
//

import Foundation

enum DataError: Error, CustomStringConvertible {
    case unableToEncode, unableToDecode
    
    var description: String {
        switch self {
        case .unableToDecode:
            return "데이터 디코딩을 실패하였습니다."
        case .unableToEncode:
            return "데이터 인코딩을 실패하였습니다."
        }
    }
}
