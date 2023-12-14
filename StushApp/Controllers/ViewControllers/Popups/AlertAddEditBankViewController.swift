//
//  AlertAddEditBankViewController.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 9/15/23.
//

import UIKit
import RxSwift

class AlertAddEditBankViewController: UIViewController {
    
    @IBOutlet weak var viewMakePrimary: UIStackView!
    @IBOutlet weak var etRoutingNumber: UITextField!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var etIBANNumber: UITextField!
    @IBOutlet weak var etBankName: UITextField!
    @IBOutlet weak var btnMakePrimary: UIButton!
    var delegate: PopUpDismissDelegate?
    var isFromEdit : Bool = false
    var alertMsg = ""
    var bankObj : Bank?
    var bankViewModel = BankViewModel.shared
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerObservers()
        setUI()
    }
    
    fileprivate func registerObservers() {
        bankViewModel.accountCreated.observe(on: MainScheduler.instance)
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
                                self.dismiss(animated: true, completion: nil)
                                delegate?.onControllerReAppear()
                            } else {
                                self.showAlertDialog(errorMsg: element.data?.message ?? "")
                            }
                        }
                        break
                    case .failure:
                        self.hideLoader()
                        self.showAlertDialog(errorMsg: element.error?.localizedDescription ?? Constants.kFailed)
                        break
                    }
                }
                
            })
            .disposed(by: bag)
    }
    
    private func setUI(){
        lblTitle.text = isFromEdit ? "Edit Bank" : "Add Bank"
        btnMakePrimary.setTitle("", for: .normal)
        btnMakePrimary.setImage(Images.CHECKBOX_DISABLED, for: .normal)
        btnMakePrimary.setImage(Images.CHECKBOX_ENABLED, for: .selected)
        
        if bankObj != nil && isFromEdit {
            viewMakePrimary.isHidden = true
            etBankName.text = bankObj?.name
            etIBANNumber.text = bankObj?.accountNumber
            etRoutingNumber.text = bankObj?.routingNumber
            btnMakePrimary.isSelected = false
        }
    }
    
    private func validateInput() -> Bool {
        if etBankName.text!.removeLeadingAndTrailingSpaces().isEmpty {
            alertMsg = Constants.kAddBankName
            return false
        } else if etIBANNumber.text!.removeLeadingAndTrailingSpaces().isEmpty {
            alertMsg = Constants.kAddBankNumber
            return false
        } else if etRoutingNumber.text!.removeLeadingAndTrailingSpaces().isEmpty {
            alertMsg = Constants.kAddRoutingNumber
            return false
        }
        
        return true
    }
    
    private func showAlertDialog(errorMsg : String){
        AlertPopupService.sharedInstance.showAlert(inVC: self,alertDescription: errorMsg, buttonTitle: Constants.buttonOkTxt, completionButtonClick: {
            
        })
    }
    
    private func proceedToBankAPI () {
        if isFromEdit {
            callUpdateBankAPI()
        } else {
            callSaveBankAPI()
        }
    }
    
    private func callUpdateBankAPI(){
        bankViewModel.updateBankAccount(requestModel: UpdateBankRequestModel(uid: bankObj?.uid ?? "", name : etBankName.text?.removeLeadingAndTrailingSpaces() ?? "", accountNumber: etIBANNumber.text ?? "", routingNumber: etRoutingNumber.text?.removeLeadingAndTrailingSpaces() ?? "", isPrimary: btnMakePrimary.isSelected))
    }
    
    private func callSaveBankAPI() {
        bankViewModel.createBankAccount(requestModel: CreateBankRequestModel(userUid: UserDefaultsHandler.sharedInstance.getMyUserObj()?.uid ?? "", name: etBankName.text?.removeLeadingAndTrailingSpaces() ?? "", accountNumber: etIBANNumber.text ?? "", routingNumber: etRoutingNumber.text?.removeLeadingAndTrailingSpaces() ?? "", isPrimary: btnMakePrimary.isSelected))
    }
    
    @IBAction func actionButtonPress(_ sender: UIButton) {
        switch (sender) {
        case btnSave:
            if validateInput() {
                proceedToBankAPI()
            } else {
                self.showAlertDialog(errorMsg: alertMsg)
            }
            break
        case btnMakePrimary:
            btnMakePrimary.isSelected = !btnMakePrimary.isSelected
            break
        case btnCancel:
            self.dismiss(animated: true, completion: nil)
            break
        default:
            break
        }
    }
}
