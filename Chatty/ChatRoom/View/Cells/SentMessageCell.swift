//
//  SentMessageCell.swift
//  Chatty
//
//  Created by typedef on 2/13/20.
//  Copyright © 2020 typedef. All rights reserved.
//

import UIKit

class SentMessageCell: UITableViewCell {
    
    private static let constWidth = CGFloat(240)
    private static let constFont = UIFont.systemFont(ofSize: 14)
    private static let constVerticalInsets = CGFloat(36)
    
    @IBOutlet weak var calloutBgView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    
    private var message: ChatMessageViewEntity? {
        didSet(value) {
            self.messageLabel.text = message?.getMessageText()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.messageLabel.textColor = .white
        
        self.calloutBgView.backgroundColor = UIColor(red: 0.341, green: 0.788, blue: 0.361, alpha: 1)
        self.calloutBgView.layer.cornerRadius = 8
        self.calloutBgView.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setMessage(message: ChatMessageViewEntity) {
        self.message = message
    }
    
    static func getMessageHeight(message: String) -> CGFloat {
        return message.height(withConstrainedWidth: constWidth,
                              font: constFont) + constVerticalInsets
    }
    
}
