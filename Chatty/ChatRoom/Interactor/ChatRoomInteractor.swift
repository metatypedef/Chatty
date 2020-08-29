//
//  ChatRoomInteractor.swift
//  ChatRoom
//
//  Created typedef on 2/13/20.
//  Copyright © 2020 typedef. All rights reserved.
//

import UIKit
import CommonCrypto

/// ChatRoom Module Interactor
class ChatRoomInteractor: ChatRoomInteractorProtocol {

    private lazy var cryptoBot = CryptoBot()
    private lazy var testChatRoom = ChatRoomEntity(interlocutorId: self.cryptoBot.botId,
                                                   interlocutorName: self.cryptoBot.name)
    
    func fetch(objectFor presenter: ChatRoomPresenterProtocol) {
        presenter.interactor(self, didFetch: self.generateTestChatRoomEntity())
    }
    
    func sendMessage(presenter: ChatRoomPresenterProtocol, message: String) {
        let appDataManager = AppDataManager.shared
        if let userId = appDataManager.userId {
            // sent messsage
            self.testChatRoom.addMessage(message: ChatMessageEntity(authorId: userId, message: message) )
            presenter.interactor(self, didFetch: self.testChatRoom)

            // generate response from cryptoBot
            self.cryptoBot.generateResponseToMessage(message: message, callback: { [unowned self] (response) in
                self.testChatRoom.addMessage(message: ChatMessageEntity(authorId: self.cryptoBot.botId,
                                                                        message: response ))
                presenter.interactor(self, didFetch: self.testChatRoom)
            })
            
        }
    }
    
    private func generateTestChatRoomEntity() -> ChatRoomEntity {
        
        // save my test user in userdefaults
        let appDataManager = AppDataManager.shared
        appDataManager.userId = "999"
        
        // generate test initial messages
        self.testChatRoom.clearMessages()
        self.testChatRoom.addMessage(message: ChatMessageEntity(authorId: self.cryptoBot.botId,
                                                                message: "Welcome to the DarkSide!! ))") )
        
        return self.testChatRoom
    }
    
}

private class CryptoBot {
     
    let botId = "666"
    let name = "CryptoChert"

    func generateResponseToMessage(message: String, callback: @escaping ((String) -> Void) ) {
        // take some rest...
        let deadLine = DispatchTime.now() + 1
        DispatchQueue.global().asyncAfter(deadline: deadLine) {
            // and generate sha256 response
            let response = self.sha256(text: message)
            DispatchQueue.main.async {
                callback(response)
            }
        }
    }
    
    private func sha256(text: String) -> String{
        if let stringData = text.data(using: String.Encoding.utf8) {
            return hexStringFromData(input: digest(input: stringData as NSData))
        }
        return ""
    }

    private func digest(input : NSData) -> NSData {
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        var hash = [UInt8](repeating: 0, count: digestLength)
        CC_SHA256(input.bytes, UInt32(input.length), &hash)
        return NSData(bytes: hash, length: digestLength)
    }

    private  func hexStringFromData(input: NSData) -> String {
        var bytes = [UInt8](repeating: 0, count: input.length)
        input.getBytes(&bytes, length: input.length)

        var hexString = ""
        for byte in bytes {
            hexString += String(format:"%02x", UInt8(byte))
        }

        return hexString
    }
    
    
}
