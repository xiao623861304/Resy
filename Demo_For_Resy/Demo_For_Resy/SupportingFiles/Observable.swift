//
//  Observable.swift
//  Demo_For_Resy
//
//  Created by yan feng on 1/14/25.
//

import Foundation

struct Observable<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    var value: T {
        didSet {
            listener?(value)
        }
    }
    init(_ value: T) {
        self.value = value
    }
    mutating func bind(listener: Listener?) {
        self.listener = listener
    }
}
