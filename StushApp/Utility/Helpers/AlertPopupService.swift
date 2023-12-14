//
//  AlertPopupService.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 8/22/23.
//

import Foundation
import UIKit
import MZFormSheetPresentationController

class AlertPopupService{
    
    static let sharedInstance = AlertPopupService()
    private init() {}
    
    func showAlert(inVC vc: UIViewController, alertDescription : String, buttonTitle: String, completionButtonClick: @escaping () -> Void, isTwoButton: Bool = false, buttonCancelTitle : String = "No") {
        let storyBoard = Storyboards.POPUP
        let alertViewController = (storyBoard.instantiateViewController(withIdentifier: AlertCompleteProfileViewController.className) as! AlertCompleteProfileViewController)
        alertViewController.bottomButtonAction = completionButtonClick
        alertViewController.alertDescription = alertDescription
        alertViewController.buttonTitle = buttonTitle
        alertViewController.isTwoButton = isTwoButton
        alertViewController.buttonNoTitle = buttonCancelTitle
        presentAlertController(vc, alertPopup: alertViewController)
    }
    
    fileprivate func presentAlertController(_ vc: UIViewController, alertPopup: AlertCompleteProfileViewController) {
        if let controller = Router.shared.topMostController() as? MZFormSheetPresentationViewController, let contentController = controller.contentViewController {
            if contentController.isKind(of: AlertCompleteProfileViewController.self) {
                return
            }
        }
        let formSheetController = MZFormSheetPresentationViewController(contentViewController: alertPopup)
        formSheetController.presentationController?.contentViewSize = CGSize(width: vc.view.frame.width, height: vc.view.frame.height)
        formSheetController.presentationController?.shouldCenterHorizontally = true
        formSheetController.presentationController?.shouldCenterVertically = true
        formSheetController.contentViewControllerTransitionStyle = .slideAndBounceFromBottom
        vc.present(formSheetController, animated: true, completion: nil)
    }
    
    func showSessionTimeoutAlert() {
        DispatchQueue.main.async {
            if let vc = Router.shared.topMostController() {
                    AlertPopupService.sharedInstance.showAlert(inVC: vc, alertDescription: Constants.kSessionExpiredMessage, buttonTitle: Constants.buttonOkTxt, completionButtonClick: {
                        let domain = Bundle.main.bundleIdentifier!
                        UserDefaults.standard.removePersistentDomain(forName: domain)
                        UserDefaults.standard.synchronize()
                        print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
                        ModeSelection.instance.signupMode()
                    })
                
            }
        }
    }
    
    func showComingSoonDialog(_ vc: UIViewController){
        showAlert(inVC: vc,alertDescription: Constants.comingSoon, buttonTitle: Constants.buttonOkTxt, completionButtonClick: {
            
        })
    }
    
}
