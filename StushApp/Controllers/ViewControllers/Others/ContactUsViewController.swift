//
//  ContactUsViewController.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 9/26/23.
//

import UIKit

class ContactUsViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var etFeedback: UITextView!
    @IBOutlet weak var btnTalkAgent: UIButton!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var btnFAQ: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        etFeedback.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if etFeedback.textColor == UIColor.lightGray {
            etFeedback.text = nil
            etFeedback.textColor = UIColor.black
            }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if etFeedback.text.isEmpty {
            etFeedback.text = "Tell us something.."
            etFeedback.textColor = UIColor.lightGray
        }
    }
    
    func showAlertDialog(){
        AlertPopupService.sharedInstance.showAlert(inVC: self,alertDescription: Constants.comingSoon, buttonTitle: Constants.buttonOkTxt, completionButtonClick: {
            
        })
    }
    
    @IBAction func actionButtonPress(_ sender: UIButton) {
        switch (sender) {
        case btnFAQ:
            AlertPopupService.sharedInstance.showComingSoonDialog(self)
            break
        case btnBack:
            self.navigationController?.popViewController(animated: true)
            break
        case btnSend:
            break
        case btnTalkAgent:
            AlertPopupService.sharedInstance.showComingSoonDialog(self)
            break
        default:
            break
        }
    }
    
}
