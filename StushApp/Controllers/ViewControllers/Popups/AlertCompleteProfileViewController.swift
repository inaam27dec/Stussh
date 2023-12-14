//
//  AlertCompleteProfileViewController.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 9/6/23.
//

import UIKit

class AlertCompleteProfileViewController: UIViewController {

    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnBottom: UIButton!
    @IBOutlet weak var lblDescription: UILabel!
    var bottomButtonAction: (() -> Void)? = nil
    var alertDescription: String = ""
    var buttonTitle: String = ""
    var buttonNoTitle : String = "No"
    var isTwoButton = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAlert()
    }
    
    func setAlert(){
        btnBottom.setTitle(buttonTitle, for: .normal)
        lblDescription.text = alertDescription
        if isTwoButton {
            btnCancel.isHidden = false
        } else {
            btnCancel.isHidden = true
        }
    }

    @IBAction func actionCancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionCompleteProfile(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        bottomButtonAction?()
    }
}
