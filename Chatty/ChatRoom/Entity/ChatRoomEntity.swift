//
//  ChatRoomEntity.swift
//  ChatRoom
//
//  Created typedef on 2/13/20.
//  Copyright © 2020 typedef. All rights reserved.
//

import UIKit

/// ChatRoom Module Entity
class ChatMessageEntity {
    
    private(set) var message: String
    private(set) var authorId: String
    
    init(authorId: String, message: String) {
        self.authorId = authorId
        self.message = message
    }
    
}

class ChatRoomEntity {

    private(set) var interlocutorId: String
    private(set) var interlocutorName: String
    private(set) lazy var messages = [ChatMessageEntity]()
    
    init(interlocutorId: String, interlocutorName: String) {
        self.interlocutorId = interlocutorId
        self.interlocutorName = interlocutorName
    }
    
    func addMessage(message: ChatMessageEntity) {
        self.messages.append(message)
    }
    
    func clearMessages() {
        self.messages.removeAll()
    }
    
}
