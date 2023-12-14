//
//  AuthModels.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 9/11/23.
//

import Foundation

struct LoginRequestModel : Codable {
    let email: String
    let password: String
}

struct LoginResponseModel: Codable {
    let data: LoginInfo?
    let isError: Bool
    let message: String
}

struct LoginInfo: Codable {
    
    var accessToken: String
    var isProfileCompleted, hasJoinedAnyProgram: Bool
    var email: String
    var id: Int
    var uid, profileImage, firstName, lastName: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case isProfileCompleted = "is_profile_completed"
        case hasJoinedAnyProgram = "has_joined_any_program"
        case email, id, uid, profileImage, firstName, lastName
    }
}

struct SignUpRequestModel : Codable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
    let phoneNumber: String
    let shippingAddress: String
    let profileImage : String
    let ssn : String
    let dob : String
    let city, state, zipCode: String
}


struct GeneralResponseModel: Codable {
    let isError: Bool
    let message: String
}

struct ForgotPassRequestModel : Codable {
    let email : String
}
