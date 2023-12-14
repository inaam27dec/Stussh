//
//  EmailSentViewController.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 9/7/23.
//

import UIKit

class EmailSentViewController: UIViewController {
    
    @IBOutlet weak var btnLoginNow: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblInfo: PaddingLabel!
    var emailAddress: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    func setView(){
        let mainString = "An Email has been sent to the registered email \(emailAddress). Please use the password sent in your email to login. You can change your password after login."
        let attributedString = NSMutableAttributedString.init(string: "An Email has been sent to the registered email \(emailAddress). Please use the password sent in your email to login. You can change your password after login.")
        
        let range = NSString(string: mainString).range(of: emailAddress, options: String.CompareOptions.caseInsensitive)
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor: Colors.APP_PRIMARY_COLOR ?? .black], range: range)
        lblInfo.attributedText = attributedString
    }
    
    func goBackToLogin(){
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    @IBAction func actionButtonPress(_ sender: UIButton) {
        switch (sender) {
        case btnLoginNow:
            goBackToLogin()
            break
        case btnBack:
            navigationController?.popViewController(animated: true)
            break
        default:
            break
        }
    }
}
