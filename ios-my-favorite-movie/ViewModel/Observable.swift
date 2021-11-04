//
//  Observable.swift
//  ios-my-favorite-movie
//
//  Created by 황인우 on 2021/11/02.
//

import Foundation

final class Observable<T> {
    var value: T? {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T?) {
        self.value = value
    }
    
    private var listener: ((T?) -> Void)?
    
    func bind(_ listener: @escaping (T?) -> Void) {
        listener(value)
        self.listener = listener
    }
}
