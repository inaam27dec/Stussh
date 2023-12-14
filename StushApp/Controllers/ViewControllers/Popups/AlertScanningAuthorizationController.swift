//
//  AlertScanningAuthorizationController.swift
//  StushApp
//
//  Created by Moiz Farasat on 21/09/2023.
//

import Foundation
import UIKit

class AlertScanningAuthorizationController: UIViewController {

    
    @IBOutlet weak var btnBottom: UIButton!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTermsAndConditions: UILabel!
    @IBOutlet weak var btnCheckbox: UIButton!
    var bottomButtonAction: (() -> Void)? = nil
    var alertDescription: String = ""
    var buttonTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        //setAlert()
    }
    
    private func setUI(){
        btnCheckbox.setImage(Images.CHECKBOX_DISABLED, for: .normal)
        btnCheckbox.setImage(Images.CHECKBOX_ENABLED, for: .selected)
        let textToHighlight = Constants.termsAndConditions
        var text = lblDescription.text
        let attributedText = text?.attributedStringWithColor([textToHighlight], color: Colors.APP_SECONDARY_COLOR!)
        lblDescription.attributedText = attributedText

        }

    @IBAction func btnActionCheckBox(_ sender: Any) {
        btnCheckbox.isSelected = !btnCheckbox.isSelected
        print ("checkBox")
    }
    
    @IBAction func btnActionContinue(_ sender: Any) {
        if btnCheckbox.isSelected {
            self.dismiss(animated: true, completion: {
                Router.shared.showScanningWaitingDialog(inViewController: self)
            })
        } else {
            AlertPopupService.sharedInstance.showAlert(inVC: self,alertDescription: Constants.termsAndConditionsMandatoryCheckError, buttonTitle: Constants.buttonOkTxt, completionButtonClick: {})

        }

    }
    func setAlert(){
        btnBottom.setTitle(buttonTitle, for: .normal)
        lblDescription.text = alertDescription
    }
}

