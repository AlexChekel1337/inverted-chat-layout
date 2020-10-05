//
//  ChatMessage.swift
//  Messaging
//
//  Created by Александр Чекель on 05.10.2020.
//

import Foundation

struct ChatMessage: Hashable {
    let text: String
    let identifier = UUID().uuidString
    let timestamp = Date().timeIntervalSince1970
    
    static func == (lhs: ChatMessage, rhs: ChatMessage) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
