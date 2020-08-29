//
//  ChatRoomViewEntity.swift
//  Chatty
//
//  Created by typedef on 2/13/20.
//  Copyright © 2020 typedef. All rights reserved.
//

import UIKit

class ChatRoomViewEntity {

    private let entity: ChatRoomEntity
    
    init(entity: ChatRoomEntity) {
        self.entity = entity
    }
    
    func getMessages() -> [ChatMessageViewEntity] {
        return self.entity.messages.map { (messageEntity) -> ChatMessageViewEntity in
            let isMine = messageEntity.authorId != self.entity.interlocutorId
            return ChatMessageViewEntity(entity: messageEntity, isMine: isMine)
        }
    }
    
    func getInterlocutorName() -> String {
        return self.entity.interlocutorName
    }
    
}

class ChatMessageViewEntity {

    private let entity: ChatMessageEntity
    let isMine: Bool
    
    init(entity: ChatMessageEntity, isMine: Bool) {
        self.entity = entity
        self.isMine = isMine
    }
    
    func getMessageText() -> String {
        return self.entity.message
    }
    
}
