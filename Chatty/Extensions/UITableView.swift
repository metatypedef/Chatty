//
//  UITableView.swift
//  Chatty
//
//  Created by typedef on 2/13/20.
//  Copyright © 2020 typedef. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func scrollToBottom(animated: Bool = true) {
        let section = self.numberOfSections
        if section > 0 {
            let row = self.numberOfRows(inSection: section - 1)
            if row > 0 {
                self.scrollToRow(at: IndexPath(row: row-1, section: section-1), at: .bottom, animated: animated)
            }
        }
    }
}
