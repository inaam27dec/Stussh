//
//  ProfileModels.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 9/14/23.
//

import Foundation

struct ProfileResponseModel: Codable {
    let data: ProfileDataClass
    let isError: Bool
    let message: String
}

// MARK: - DataClass
struct ProfileDataClass: Codable {
    let id: Int
    let uid, email, firstName, lastName: String
    let phoneNumber: String?
    let password: String
    let shippingAddress,city,state,zipCode, ssn: String?
    let createdAt, updatedAt: String
    let isProfileCompleted, hasJoinedAnyProgram: Bool
    let dob: String
    let profileImage: String?
    let banks: [Bank]
    let income: Income?
}

// MARK: - Bank
struct Bank: Codable {
    let id: Int
    let uid, name: String
    let userID: Int
    let isPrimary: Bool
    let accountNumber: String
    let routingNumber: String

    enum CodingKeys: String, CodingKey {
        case id, uid, name
        case userID = "userId"
        case isPrimary, accountNumber, routingNumber
    }
}

// MARK: - Income
struct Income: Codable {
    let id: Int
    let uid: String
    let employementType, userID, amountInDollars: Int
    let companyAddress, companyContactNumber: String
    let salaryType: Int
    let companyName: String

    enum CodingKeys: String, CodingKey {
        case id, uid, employementType
        case userID = "userId"
        case amountInDollars, companyAddress, companyContactNumber, salaryType, companyName
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}


struct EditProfileRequestModel: Codable {
    let uid, firstName, lastName, phoneNumber: String
    let shippingAddress, ssn, dob: String
    let isProfileCompleted, hasJoinedAnyProgram: Bool
    let profileImage, city, state, zipCode: String
}
