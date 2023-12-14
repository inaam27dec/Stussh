//
//  Date+Extension.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 8/22/23.
//


import Foundation

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM, yyyy"
        return dateFormatter.string(from: self)
    }
    
    func toServerDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.string(from: self)
    }
}
