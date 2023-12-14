//
//  ForgotPasswordViewController.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 9/7/23.
//

import UIKit
import RxSwift

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var etEmailAddress: UITextField!
    @IBOutlet weak var btnResetPassword: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    private var alertMsg: String = ""
    var authenticationViewModel = AuthenticationViewModel.shared
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerObservers()
    }
    
    fileprivate func registerObservers() {
        
        AuthenticationViewModel.shared.generalData.observe(on: MainScheduler.instance)
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
                                moveToEmailSentScreen()
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
    
    func showAlertDialog(errorMsg : String){
        AlertPopupService.sharedInstance.showAlert(inVC: self,alertDescription: errorMsg, buttonTitle: Constants.buttonOkTxt, completionButtonClick: {
            
        })
    }
    
    func moveToEmailSentScreen(){
        let emailSentVC = Storyboards.AUTHENTICATION.instantiateViewController(withIdentifier: EmailSentViewController.className) as! EmailSentViewController
        emailSentVC.emailAddress = etEmailAddress.text!
        self.navigationController?.pushViewController(emailSentVC, animated: true)
    }
    
    func validateInput() -> Bool {
        if etEmailAddress.text!.isEmpty {
            alertMsg = Constants.kEnterEmail
            return false
        } else if etEmailAddress.text!.isValidEmail == false {
            alertMsg = Constants.kValidEmail
            return false
        }
        return true
    }
    
    func proceedToResetPassword(){
        if validateInput() {
            authenticationViewModel.forgotPass(requestModel: ForgotPassRequestModel(email: etEmailAddress!.text!))
        } else {
            showAlertDialog(errorMsg: alertMsg)
        }
    }
    
    @IBAction func actionButtonPress(_ sender: UIButton) {
        switch (sender) {
        case btnResetPassword:
            proceedToResetPassword()
            break
        case btnBack:
            navigationController?.popViewController(animated: true)
            break
        default:
            break
        }
    }
}
