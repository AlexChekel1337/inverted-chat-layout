//
//  ServiceMessage.swift
//  Messaging
//
//  Created by Александр Чекель on 05.10.2020.
//

import Foundation

struct ServiceMessage: Hashable {
    let text: String
    let identifier = UUID().uuidString
    
    static func == (lhs: ServiceMessage, rhs: ServiceMessage) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
