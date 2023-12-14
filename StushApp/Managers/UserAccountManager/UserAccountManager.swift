//
//  UserAccountManager.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 8/22/23.
//

import Foundation
import RxSwift

class UserAccountManager {
    let userDisplayName: BehaviorSubject<String> = BehaviorSubject(value: "")
    let userEmailAddress: BehaviorSubject<String> = BehaviorSubject(value: "")
    let userName = BehaviorSubject(value: UserDefaultsHandler.sharedInstance.getUserName() ?? "")
    
    
    static let shared = UserAccountManager()
    
    private var bag = DisposeBag()
    
    private init(){}
}
