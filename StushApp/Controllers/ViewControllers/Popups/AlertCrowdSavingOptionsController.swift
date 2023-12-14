//
//  AlertCrowdSavingOptionsController.swift
//  StushApp
//
//  Created by Moiz Farasat on 21/09/2023.
//

import UIKit

class AlertCrowdSavingOptionsController: UIViewController {
    
    var strWeeklySavingCost: String?
    var strNumberofWeeks: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnActionWeeklySavingGoal(_ sender: Any) {
    }
    
    @IBAction func btnActionNumberOfWeeks(_ sender: Any) {
    }
    
    @IBAction func btnActionProceed(_ sender: Any) {
        
        if let selectedWeeklySavingCost = strWeeklySavingCost, let selecctedNumberofWeeks = strNumberofWeeks, !selectedWeeklySavingCost.isEmpty, !selecctedNumberofWeeks.isEmpty  {
            
            
        } else {
            AlertPopupService.sharedInstance.showAlert(inVC: self,alertDescription: Constants.mandatoryFieldsError, buttonTitle: Constants.buttonOkTxt, completionButtonClick: {})
        }
    }
}
