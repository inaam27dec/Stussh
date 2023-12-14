//
//  BanksModels.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 9/21/23.
//

import Foundation

struct CreateBankRequestModel : Codable {
    let userUid, name, accountNumber, routingNumber : String
    let isPrimary: Bool
}

struct MarkAsPrimaryRequestModel : Codable {
    let uid: String
    let userUid: String
}

struct UpdateBankRequestModel : Codable {
    let uid, name, accountNumber, routingNumber : String
    let isPrimary: Bool
}

struct DeleteBankRequestModel : Codable {
    let uid: String
}


