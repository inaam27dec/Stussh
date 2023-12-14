//
//  StushCardModels.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 9/23/23.
//

import Foundation

struct GetCardDetailsRequestModel: Codable {
    let userUid: String
}

struct GetStushCardResponseModel: Codable {
    let data: StushCardDetails
    let isError: Bool
    let message: String
}

// MARK: - DataClass
struct StushCardDetails: Codable {
    let id: Int
    let uid, cardNumber, expiryDate: String
    let cvv: Int
    let paymentNetwork: String
    let isActivated: Bool
    let userID: Int

    enum CodingKeys: String, CodingKey {
        case id, uid, cardNumber, expiryDate, cvv, paymentNetwork, isActivated
        case userID = "userId"
    }
}
