//
//  ChatRoomPresenter.swift
//  ChatRoom
//
//  Created typedef on 2/13/20.
//  Copyright © 2020 typedef. All rights reserved.
//

import UIKit

/// ChatRoom Module Presenter
class ChatRoomPresenter {
    
    weak private var _view: ChatRoomViewProtocol?
    private var interactor: ChatRoomInteractorProtocol
    private var wireframe: ChatRoomRouterProtocol
    
    init(view: ChatRoomViewProtocol) {
        self._view = view
        self.interactor = ChatRoomInteractor()
        self.wireframe = ChatRoomRouter()
    }
    
}

// MARK: - extending ChatRoomPresenter to implement it's protocol
extension ChatRoomPresenter: ChatRoomPresenterProtocol {
    
    func fetch(objectFor view: ChatRoomViewProtocol) {
        self.interactor.fetch(objectFor: self)
    }
    
    func sendMessage(message: String) {
        self.interactor.sendMessage(presenter: self, message: message)
    }
    
    func interactor(_ interactor: ChatRoomInteractorProtocol, didFetch object: ChatRoomEntity) {
        self._view?.set(object: ChatRoomViewEntity(entity: object))
    }
    
    func interactor(_ interactor: ChatRoomInteractorProtocol, didFailWith error: Error) {
        
    }
    
    
    
    
}
