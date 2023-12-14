//
//  ProgramConfirmationViewController.swift
//  StushApp
//
//  Created by Moiz Farasat on 22/09/2023.
//

import UIKit

class ProgramConfirmationViewController: UIViewController {

    @IBOutlet weak var lblTopBar: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var btnCheckBoxTermsAndConditions: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()

        // Do any additional setup after loading the view.
    }
    
    private func setUI(){
        btnCheckBoxTermsAndConditions.setImage(Images.CHECKBOX_DISABLED, for: .normal)
        btnCheckBoxTermsAndConditions.setImage(Images.CHECKBOX_ENABLED, for: .selected)
        }

    
    @IBAction func btnActionBack(_ sender: Any) {
        self.popController()
    }
    
    @IBAction func btnActionTermsAndConditions(_ sender: Any) {
        btnCheckBoxTermsAndConditions.isSelected = !btnCheckBoxTermsAndConditions.isSelected

    }
    
     @IBAction func btnActionJoinNow(_ sender: Any) {
         
         if btnCheckBoxTermsAndConditions.isSelected {
             self.dismiss(animated: true, completion: {
                 //Router.shared.showScanningWaitingDialog(inViewController: self)
             })
         } else {
             AlertPopupService.sharedInstance.showAlert(inVC: self,alertDescription: Constants.termsAndConditionsMandatoryCheckError, buttonTitle: Constants.buttonOkTxt, completionButtonClick: {})

         }

     }
}
