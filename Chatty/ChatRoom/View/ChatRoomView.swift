//
//  ChatRoomView.swift
//  ChatRoom
//
//  Created typedef on 2/13/20.
//  Copyright © 2020 typedef. All rights reserved.
//

import UIKit

/// ChatRoom Module View
class ChatRoomView: UIViewController {
    
    private var presenter : ChatRoomPresenterProtocol?
    
    private var object : ChatRoomViewEntity?
    
    private let tableViewRecivedCellId = String(describing: ReceivedMessageCell.self)
    private let tableViewSentCellId = String(describing: SentMessageCell.self)
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textFieldBgView: UIView!
    
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var inputPanelBottomConstraints: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textFieldBgView.layer.cornerRadius = 8
        self.textFieldBgView.layer.masksToBounds = true
        
        self.sendButton.layer.cornerRadius = 8
        self.sendButton.layer.masksToBounds = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeShown(note:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        self.tableView.register(UINib(nibName: self.tableViewRecivedCellId, bundle: nil),
                                forCellReuseIdentifier: self.tableViewRecivedCellId)
        
        self.tableView.register(UINib(nibName: self.tableViewSentCellId, bundle: nil),
                                forCellReuseIdentifier: self.tableViewSentCellId)
        
        self.presenter = ChatRoomPresenter(view: self)
        
        // Informs the Presenter that the View is ready to receive data.
        self.presenter?.fetch(objectFor: self)
        
    }
    
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        if let text = self.textField.text, text.isEmpty == false {
            self.presenter?.sendMessage(message: text)
            self.textField.text = nil
            self.textField.resignFirstResponder()
        }
    }
    
    @objc func keyboardWillBeShown(note: Notification) {
        if let userInfo = note.userInfo {
            if let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                UIView.animate(withDuration: 0.3) {
                    self.inputPanelBottomConstraints.constant = keyboardFrame.size.height
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    @objc func keyboardWillBeHidden(note: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.inputPanelBottomConstraints.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
}

// MARK: - extending ChatRoomView to implement it's protocol
extension ChatRoomView: ChatRoomViewProtocol {
    
    func set(object: ChatRoomViewEntity) {
        self.object = object
        
        self.title = self.object?.getInterlocutorName()
        
        self.tableView.reloadData()
        self.tableView.scrollToBottom(animated: true)
    }
    
}

extension ChatRoomView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.object?.getMessages().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let messages = self.object?.getMessages() {
            let message = messages[indexPath.row]
            if message.isMine {
                let cell = tableView.dequeueReusableCell(withIdentifier: self.tableViewRecivedCellId) as! ReceivedMessageCell
                cell.setMessage(message: message)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: self.tableViewSentCellId) as! SentMessageCell
                cell.setMessage(message: message)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let messages = self.object?.getMessages() {
            let message = messages[indexPath.row]
            if message.isMine {
                return ReceivedMessageCell.getMessageHeight(message: message.getMessageText())
            } else {
                return SentMessageCell.getMessageHeight(message: message.getMessageText())
                
            }
        }
        return 64
    }
    
}
