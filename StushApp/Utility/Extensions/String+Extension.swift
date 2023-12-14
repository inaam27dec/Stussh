//
//  String+Extension.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 8/22/23.
//

import Foundation
import UIKit
import SwiftJWT

extension String {
    
    func convertBase64ToImage() -> UIImage? {
        if let data = Data(base64Encoded: self) {
            return UIImage(data: data)
        }
        return nil
    }
    
    func isValidIBAN() -> Bool {
        // Remove spaces and convert to uppercase
        let iban = self.replacingOccurrences(of: " ", with: "").uppercased()
        
        // Check if IBAN is the correct length
        if iban.count < 15 || iban.count > 34 {
            return false
        }
        
        // Check if IBAN contains only alphanumeric characters
        let alphanumericCharacterSet = CharacterSet.alphanumerics
        if iban.rangeOfCharacter(from: alphanumericCharacterSet.inverted) != nil {
            return false
        }
        
        // Rearrange IBAN
        let ibanPrefix = iban.prefix(4) // First four characters
        let ibanSuffix = iban.suffix(from: iban.index(iban.startIndex, offsetBy: 4)) // Characters after the first four
        
        let rearrangedIBAN = "\(ibanSuffix)\(ibanPrefix)"
        
        // Convert IBAN to a numeric string
        var numericIBAN = ""
        for character in rearrangedIBAN {
            if let digit = character.unicodeScalars.first?.value {
                if digit >= 65 && digit <= 90 {
                    // Convert letters to digits (A=10, B=11, ..., Z=35)
                    numericIBAN += String(digit - 55)
                } else {
                    // Keep digits as they are
                    numericIBAN += String(character)
                }
            }
        }
        
        // Convert numeric IBAN to an integer
        if let ibanValue = Int(numericIBAN) {
            // Check if the remainder when dividing by 97 is 1
            return ibanValue % 97 == 1
        }
        
        return false
    }
    
    func convertUTCDateStringToLocalDateString() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        // Set the time zone to UTC
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let utcDate = dateFormatter.date(from: self) {
            // Convert UTC date to the local time zone
            dateFormatter.timeZone = TimeZone.current
            
            // Set up the date components for the desired format
            dateFormatter.dateFormat = "d MMMM, yyyy"
            
            // Format the date to the desired string format
            return dateFormatter.string(from: utcDate)
        }
        
        return nil // Return nil if parsing fails
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func addSpacesAfter4Digits() -> String {
            var result = ""
            
            // Iterate through the characters in the string
            for (index, character) in self.enumerated() {
                // Add the character to the result string
                result.append(character)
                
                // Check if we need to add spaces after 4 digits
                if (index + 1) % 4 == 0 && (index + 1) != self.count {
                    result.append("  ") // Add two spaces
                }
            }
            
            return result
        }
    
    func serverDateToDatePickerFormat() -> String? {
        let serverDateFormatter = DateFormatter()
        serverDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let date = serverDateFormatter.date(from: self) {
            let datePickerFormatter = DateFormatter()
            datePickerFormatter.dateFormat = "yyyy-MM-dd'T'00:00.000Z"
            return datePickerFormatter.string(from: date)
        }
        
        return nil
    }
    
    func convertToZuluTime() -> String? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            
            if let date = dateFormatter.date(from: self) {
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
                return dateFormatter.string(from: date)
            }
            
            return nil
        }
    
    func withBoldText(texts: [String], font: UIFont? = nil, withBoldFont boldFont: UIFont? = nil, color: UIColor? = nil) -> NSAttributedString {
        let _font = font ?? boldFont
        let fullString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: _font as Any])
        
        for text in texts {
            var boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: boldFont as Any]
            
            if let color = color {
                boldFontAttribute = [NSAttributedString.Key.font: boldFont as Any,
                                     NSAttributedString.Key.foregroundColor: color]
            }
            
            let range = (self as NSString).range(of: text)
            fullString.addAttributes(boldFontAttribute, range: range)
        }
        
        return fullString
    }
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String? {
        guard let data = data(using: .utf8)?.base64EncodedString() else { return nil }
        return data
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    public func isValidPassword() -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d].{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    
    var isValidEmail: Bool {
        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    
    var isValidSSN: Bool {
        // Remove hyphens if present
        let cleanedSSN = self.replacingOccurrences(of: "-", with: "")
        
        // Check for the correct length (9 digits)
        guard cleanedSSN.count == 9 else {
            return false
        }
        
        // Check if it contains only digits
        guard let _ = Int(cleanedSSN) else {
            return false
        }
        
        // Check for invalid SSN patterns
        let invalidPatterns = ["000", "666", "900-999"]
        for pattern in invalidPatterns {
            if cleanedSSN.hasPrefix(pattern) {
                return false
            }
        }
        
        // Passed all checks, consider it valid
        return true
    }
    
    var isStrongPassword: Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d).{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: self)
    }
    
    func isValidUrl() -> Bool {
        let urlRegEx = "^(https?://)?(www\\.)?([-a-z0-9]{1,63}\\.)*?[a-z0-9][-a-z0-9]{0,61}[a-z0-9]\\.[a-z]{2,6}(/[-\\w@\\+\\.~#\\?&/=%]*)?$"
        let urlTest = NSPredicate(format:"SELF MATCHES %@", urlRegEx)
        let result = urlTest.evaluate(with: self)
        return result
    }
    
    func attributedStringWithColor(_ strings: [String], color: UIColor, characterSpacing: UInt? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        for string in strings {
            let range = (self as NSString).range(of: string)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
        
        guard let characterSpacing = characterSpacing else {return attributedString}
        
        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))
        
        return attributedString
    }
    
    func addHyperLink(_ strings:[String], color: UIColor, characterSpacing: UInt? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        
        let attributesForUnderLine: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
            .underlineStyle: NSUnderlineStyle.single.rawValue]
        
        for string in strings {
            let range = (self as NSString).range(of: string)
            attributedString.addAttributes(attributesForUnderLine, range: range)
        }
        
        guard let characterSpacing = characterSpacing else {return attributedString}
        
        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))
        
        return attributedString
    }
    
    func htmlAttributed(family: String?, size: CGFloat, color: UIColor) -> NSAttributedString? {
        do {
            let htmlCSSString = "<style>" +
            "html *" +
            "{" +
            "font-size: \(size)pt !important;" +
            "color: #\(color.hexString) !important;" +
            "font-family: \(family ?? "Helvetica"), Helvetica !important;" +
            "}</style> \(self)"
            
            guard let data = htmlCSSString.data(using: String.Encoding.utf8) else {
                return nil
            }
            
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func removeLeadingAndTrailingSpaces() -> String {
        
        let trimmedString = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedString
    }
    
    var condensed: String {
        return replacingOccurrences(of: "[\\s\n]+", with: " ", options: .regularExpression, range: nil)
    }
    
    /// Returns a condensed string, with no whitespaces at all and no new lines.
    var extraCondensed: String {
        return replacingOccurrences(of: "[\\s\n]+", with: "", options: .regularExpression, range: nil)
    }
    
    
}
