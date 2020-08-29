//
//  ChatRoomContracts.swift
//  ChatRoom
//
//  Created typedef on 2/13/20.
//  Copyright © 2020 typedef. All rights reserved.
//

import UIKit

//MARK: View -
/*
 Should replace "class" with "BaseViewProtocol" if available;
 & that will allow the View to act as a UIViewController;
 & Implement common view functions.
 */
/// ChatRoom Module View Protocol
protocol ChatRoomViewProtocol: class {
    // Update UI with value returned.
    /// Set the view Object of Type ChatRoomViewEntity
    func set(object: ChatRoomViewEntity)
}

//MARK: Interactor -
/// ChatRoom Module Interactor Protocol
protocol ChatRoomInteractorProtocol {
    // Fetch Object from Data Layer
    func fetch(objectFor presenter: ChatRoomPresenterProtocol)
    
    /// The Interactor will send new message
    func sendMessage(presenter: ChatRoomPresenterProtocol, message: String)
}

//MARK: Presenter -
/// ChatRoom Module Presenter Protocol
protocol ChatRoomPresenterProtocol {
    /// The presenter will fetch data from the Interactor thru implementing the Interactor fetch function.
    func fetch(objectFor view: ChatRoomViewProtocol)
    /// The Interactor will inform the Presenter a successful fetch.
    func interactor(_ interactor: ChatRoomInteractorProtocol, didFetch object: ChatRoomEntity)
    /// The Interactor will inform the Presenter a failed fetch.
    func interactor(_ interactor: ChatRoomInteractorProtocol, didFailWith error: Error)
    /// The presenter will send new message
    func sendMessage(message: String)
}

//MARK: Router (aka: Wireframe) -
/// ChatRoom Module Router Protocol
protocol ChatRoomRouterProtocol {
    // Show Details of Entity Object coming from ParentView Controller.
    // func showDetailsFor(object: ChatRoomEntity, parentViewController viewController: UIViewController)
}
