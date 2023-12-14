//
//  UserDefaultHandler.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 8/22/23.
//

import Foundation

class UserDefaultsHandler {
    
    private let USER_UUID = "user_uuid"
    private let IS_LOGGED_IN = "is_logged_in"
    private let LOGIN_TOKEN = "login_token"
    private let USER_NAME = "user_name"
    private let IS_SESSION_EXPIRED = "is_session_expired"
    private let USER_OBJ = "user_obj"
    
    static let sharedInstance = UserDefaultsHandler()
    
    var isSessionExpired: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: IS_SESSION_EXPIRED)
        }
        get {
            return UserDefaults.standard.bool(forKey: IS_SESSION_EXPIRED)
        }
    }
    
    private init(){}
    
    func setUUID(uuid: String) {
        UserDefaults.standard.set(uuid, forKey: USER_UUID)
    }
    
    func getUUID() -> String {
        return UserDefaults.standard.string(forKey: USER_UUID) ?? ""
    }
    
    func setLoginStatus(isLogin: Bool) {
        UserDefaults.standard.set(isLogin, forKey: IS_LOGGED_IN)
    }
    
    func getLoginStatus() -> Bool {
        return UserDefaults.standard.bool(forKey: IS_LOGGED_IN)
    }

    func setLoginToken(token: String?) {
        UserDefaults.standard.set(token, forKey: LOGIN_TOKEN)
    }
    
    func getLoginToken() -> String {
        return UserDefaults.standard.string(forKey: LOGIN_TOKEN) ?? ""
    }
    
    func setUserName(name: String?) {
        UserDefaults.standard.set(name, forKey: USER_NAME)
    }
    
    func getUserName() -> String? {
        return UserDefaults.standard.string(forKey: USER_NAME)
    }
    
    func saveMyUserObj(obj: LoginInfo) {
        do {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(obj) {
                UserDefaults.standard.set(encoded, forKey: USER_OBJ)
            }
        }
    }
    
    func getMyUserObj() -> LoginInfo? {
        if let savedData = UserDefaults.standard.data(forKey: USER_OBJ) {
            let decoder = JSONDecoder()
            if let loadedClaims = try? decoder.decode(LoginInfo.self, from: savedData) {
                return loadedClaims
            }
        }
        return nil
    }
}

