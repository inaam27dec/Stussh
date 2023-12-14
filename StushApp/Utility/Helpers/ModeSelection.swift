//
//  ModeSelection.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 8/28/23.
//

import Foundation
import UIKit

class ModeSelection {
    static let instance = ModeSelection()

    func loginMode() -> Void {
        
        if let window = AppDelegate.appDelegate().window {
            let rootVC = Storyboards.MAIN.instantiateInitialViewController()
            window.rootViewController = rootVC
            window.makeKeyAndVisible()
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {}, completion: nil)
        }
    }
    
    func signupMode() -> Void {
        if let window = AppDelegate.appDelegate().window {
            let rootVC = Storyboards.AUTHENTICATION.instantiateInitialViewController()
            window.rootViewController = rootVC
//            window.rootViewController?.navigationController?.navigationBar.isHidden = false
            window.makeKeyAndVisible()
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {}, completion: nil)
        }
    }
    
    func profileMode () -> Void {
        if let window = AppDelegate.appDelegate().window {
            let rootVC = Storyboards.PROFILE.instantiateInitialViewController()
            window.rootViewController = rootVC
            window.rootViewController?.navigationController?.navigationBar.isHidden = false
            window.makeKeyAndVisible()
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {}, completion: nil)
        }
    }
    
}
