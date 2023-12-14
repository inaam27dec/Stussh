//
//  UIImage+Extension.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 8/22/23.
//
import Foundation
import UIKit
let imageCache = NSCache<NSString, UIImage>()
extension UIImage {
    
    func toBase64() -> String? {
        if let imageData = self.jpegData(compressionQuality: 1.0) {
            return imageData.base64EncodedString()
        }
        return nil
    }
    
}
