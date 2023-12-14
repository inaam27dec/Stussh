//
//  UIColor+Extension.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 8/22/23.
//

import Foundation
import UIKit
extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        var customHex:String!
        customHex = hex + "FF"
        if customHex.hasPrefix("#") {
            let start = customHex.index(customHex.startIndex, offsetBy: 1)
            let hexColor = String(customHex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
    
    var hexString: String {
        let components = cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0
        
        let hexString = String(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)),
                               lroundf(Float(b * 255)))
        
        return hexString
    }
    
    class var themeSnackBarColor:UIColor {
        return UIColor(hex:"#3C426D")!
    }
    
    class func getColorFromName(_ name: String) -> UIColor? {
        let selector = Selector("\(name)Color")
        if UIColor.self.responds(to: selector) {
            let color = UIColor.self.perform(selector).takeUnretainedValue()
            return (color as! UIColor)
        } else {
            return nil
        }
    }

}

