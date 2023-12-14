//
//  UITextView+Extension.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 8/22/23.
//

import Foundation
import UIKit

extension UITextView {
    
    func removePadding() {
        textContainerInset = .zero
        textContainer.lineFragmentPadding = 0
    }
    
    func hyperLink(originalText: String, hyperLink: String, urlString: String) {
        let style = NSMutableParagraphStyle()
//        style.alignment = .center
        let attributedOriginalText = NSMutableAttributedString(string: originalText)
        let linkRange = attributedOriginalText.mutableString.range(of: hyperLink)
        let fullRange = NSMakeRange(0, attributedOriginalText.length)
        attributedOriginalText.addAttribute(NSAttributedString.Key.link, value: urlString, range: linkRange)
        attributedOriginalText.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: fullRange)
//        attributedOriginalText.addAttribute(NSAttributedString.Key.font, value: Fonts.DMSans.Regular12 as Any, range: fullRange)
        self.linkTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(hex: "#0779D1")!,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
        ]
        self.attributedText = attributedOriginalText
    }
}

