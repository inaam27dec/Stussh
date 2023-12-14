//
//  AppDelegate.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 8/22/23.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        setAppInitialMode()
        return true
    }

    // MARK: UISceneSession Lifecycle


    static func appDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func setAppInitialMode(){
        if (UserDefaultsHandler.sharedInstance.getLoginStatus()){
            ModeSelection.instance.loginMode()
        } else {
            ModeSelection.instance.signupMode()
        }
        
    }


}

