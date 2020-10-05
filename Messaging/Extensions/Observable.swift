//
//  Observable.swift
//  Messaging
//
//  Created by Александр Чекель on 05.10.2020.
//

import Foundation

class Observable<T> {
    
    var subscribe: (T) -> Void = { _ in }
    var value: T {
        didSet {
            subscribe(value)
        }
    }
    
    init(value: T) {
        self.value = value
    }
    
}
