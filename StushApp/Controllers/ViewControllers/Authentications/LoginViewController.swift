//
//  LoginViewController.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 8/28/23.
//

import UIKit
import RxSwift

class LoginViewController: UIViewController {
    
    @IBOutlet weak var btnRegisterNow: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var etPassword: UITextField!
    @IBOutlet weak var etEmailAddress: UITextField!
    private var alertMsg: String = ""
    
    var authenticationViewModel = AuthenticationViewModel.shared
    let bag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerObservers()
    }
    
    fileprivate func registerObservers() {
        AuthenticationViewModel.shared.loginData.observe(on: MainScheduler.instance)
            .subscribe({ [weak self] (event) in
                guard let `self` = self else { return }
                
                if let element = event.element {
                    switch element.state {
                    case .loading:
                        self.showLoader()
                        break
                    case .success:
                        self.hideLoader()
                        if let error = element.data?.isError {
                            if error == false {
                                saveUserValues(userInfo: element.data?.data)
                                ModeSelection.instance.loginMode()
                            } else {
                                showAlertDialog(errorMsg: element.data?.message ?? "")
                            }
                        }
                            
                        break
                    case .failure:
                        self.hideLoader()
                        showAlertDialog(errorMsg: element.error?.localizedDescription ?? Constants.kFailed)
                        break
                    }
                }
                
            })
            .disposed(by: bag)
    }
    
    func saveUserValues(userInfo: LoginInfo?){
        if(userInfo != nil){
            UserDefaultsHandler.sharedInstance.setLoginToken(token: userInfo?.accessToken ?? "")
            UserDefaultsHandler.sharedInstance.setLoginStatus(isLogin: true)
            UserDefaultsHandler.sharedInstance.saveMyUserObj(obj: userInfo!)
        }
    }
    
    func validateInput() -> Bool {
        if etEmailAddress.text!.isEmpty {
            alertMsg = Constants.kEnterEmail
            return false
        } else if etEmailAddress.text!.isValidEmail == false {
            alertMsg = Constants.kValidEmail
            return false
        } else if etPassword.text!.isEmpty {
            alertMsg = Constants.kEnterPassword
            return false
        }
        return true
    }
    
    func proceedToLogin(){
        if validateInput() {
            authenticationViewModel.login(requestModel: LoginRequestModel(email: etEmailAddress.text!.removeLeadingAndTrailingSpaces(), password: etPassword.text!))
        } else {
            showAlertDialog(errorMsg: alertMsg)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func showAlertDialog(errorMsg : String){
        AlertPopupService.sharedInstance.showAlert(inVC: self,alertDescription: errorMsg, buttonTitle: Constants.buttonOkTxt, completionButtonClick: {})
    }
    
    func moveToForgotPasswordScreen(){
        let forgotPassVC = Storyboards.AUTHENTICATION.instantiateViewController(withIdentifier: ForgotPasswordViewController.className) as! ForgotPasswordViewController
        self.navigationController?.pushViewController(forgotPassVC, animated: true)
    }
    
    func moveToSignUpScreen(){
        let signUpVC = Storyboards.AUTHENTICATION.instantiateViewController(withIdentifier: SignUpViewController.className) as! SignUpViewController
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @IBAction func actionClick(_ sender: UIButton) {
        switch (sender) {
        case btnLogin:
//            ModeSelection.instance.loginMode()
            proceedToLogin()
            break
        case btnForgotPassword:
            moveToForgotPasswordScreen()
            break
        case btnRegisterNow:
            moveToSignUpScreen()
            break
        default:
            break
        }
    }
}
