//
//  UIButton+Extension.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 8/22/23.
//

import Foundation
import UIKit

extension UIButton {
    
    func allowTextShrink() {
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.lineBreakMode = .byClipping
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
}

