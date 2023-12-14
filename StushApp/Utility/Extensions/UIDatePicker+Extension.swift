//
//  UIDatePicker+Extension.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 9/22/23.
//

import Foundation
import UIKit

extension UIDatePicker {
    func setDateFromServerDate(serverDate: String) {
        let serverDateFormatter = DateFormatter()
        serverDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let date = serverDateFormatter.date(from: serverDate) {
            self.date = date
        }
    }
}
