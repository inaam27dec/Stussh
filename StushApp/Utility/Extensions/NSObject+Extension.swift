//
//  NSObject+Extension.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 8/22/23.
//

import Foundation

extension NSObject {

    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
