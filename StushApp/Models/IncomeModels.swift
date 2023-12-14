//
//  IncomeModels.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 9/21/23.
//

import Foundation


struct CreateIncomeProfileRequestModel : Codable {
    let employementType, salaryType: Int
    let userUid, companyName, companyAddress, companyContactNumber: String
    let amountInDollars: Int
}

struct UpdateIncomeProfileRequestModel : Codable {
    let employementType, salaryType: Int
    let uid, userUid, companyName, companyAddress, companyContactNumber: String
    let amountInDollars: Int
}
