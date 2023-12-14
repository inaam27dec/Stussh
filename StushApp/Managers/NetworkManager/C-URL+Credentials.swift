//
//  C-URL+Credentials.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 9/11/23.
//

import Foundation

struct BaseUrl {
    static var STAGING = "https://staging5.rolustech.com:4220"
    static var LIVE = ""
}

var apiURL : String {
    return "\(BaseUrl.STAGING)"
}

struct API {
    struct Auth {
        static let LOGIN = "\(apiURL)/auth/login"
        static let SIGNUP = "\(apiURL)/auth/signup"
        static let FORGOT_PASSWORD = "\(apiURL)/auth/forgot-password"
        static let GET_STATES = "\(apiURL)/auth/states"
    }
    
    struct Bank {
        static let CREATE_BANK = "\(apiURL)/banks"
        static let MARK_AS_PRIMARY = "\(apiURL)/banks/markBankPrimary"
        static let UPDATE_BANK = "\(apiURL)/banks/update"
        static let DELETE_BANK = "\(apiURL)/banks/delete-bank"
    }
    
    struct Profile {
        static let GET_PROFILE = "\(apiURL)/profiles/{uid}"
        static let UPDATE_PROFILE = "\(apiURL)/users/update"
    }
    
    struct Income {
        static let CREATE_INCOME_PROFILE = "\(apiURL)/incomes"
        static let UPDATE_INCOME_PROFILE = "\(apiURL)/incomes/update"
    }
    
    struct StushCard {
        static let GET_DETAILS = "\(apiURL)/stush-debit-cards/details"
        static let ACTIVATE_CARD = "\(apiURL)/stush-debit-cards/activate-card"
    }
    
}
