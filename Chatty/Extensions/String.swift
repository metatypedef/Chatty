//
//  String.swift
//  Chatty
//
//  Created by typedef on 2/13/20.
//  Copyright © 2020 typedef. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin,
                                            attributes: [NSAttributedString.Key.font : font], context: nil)
        return ceil(boundingBox.height)
    }
}
