//
//  UILabel+Extension.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 8/22/23.
//

import Foundation
import UIKit

extension UILabel {
    func halfTextColorChange (fullText : String , changeText : String ) {
        let strNumber: NSString = fullText as NSString
        let range = (strNumber).range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: Colors.PINK_THEME_COLOR as Any , range: range)
//        attribute.addAttribute(NSAttributedString.Key.font, value: nil, range: range)
        self.attributedText = attribute
    }
}
