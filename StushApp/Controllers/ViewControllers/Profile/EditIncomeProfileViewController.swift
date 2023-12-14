//
//  EditIncomeProfileViewController.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 9/20/23.
//

import UIKit
import RxSwift

class EditIncomeProfileViewController: UIViewController {

    
    @IBOutlet weak var salaryTypeView: UIStackView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnMonthly: UIButton!
    @IBOutlet weak var btnBiWeekly: UIButton!
    @IBOutlet weak var btnWeekly: UIButton!
    @IBOutlet weak var etAmount: UITextField!
    @IBOutlet weak var etCompanyNumber: UITextField!
    @IBOutlet weak var etCompanyAddress: UITextField!
    @IBOutlet weak var etCompanyName: UITextField!
    @IBOutlet weak var empView: UIStackView!
    @IBOutlet weak var btnUnEmp: UIButton!
    @IBOutlet weak var btnSelfEmp: UIButton!
    @IBOutlet weak var btnRetired: UIButton!
    @IBOutlet weak var btnEmployed: UIButton!
    private var alertMsg = ""
    private var empType = EmploymentType.employed.id
    private var salaryType = SalaryType.weekly.id
    var incomeObj : Income?
    var incomeViewModel = IncomeViewModel.shared
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        registerObservers()
        setData()
        // Do any additional setup after loading the view.
    }
    
    private func setData (){
        if incomeObj != nil {
            switch (incomeObj?.employementType) {
            case EmploymentType.employed.id:
                btnEmployed.sendActions(for: .touchUpInside)
                break
            case EmploymentType.retired.id:
                btnRetired.sendActions(for: .touchUpInside)
                break
            case EmploymentType.selfEmployed.id:
                btnSelfEmp.sendActions(for: .touchUpInside)
                break
            case EmploymentType.unEmployed.id:
                btnUnEmp.sendActions(for: .touchUpInside)
                break
            default:
                break
            }
            
            switch (incomeObj?.salaryType) {
            case SalaryType.weekly.id:
                btnWeekly.sendActions(for: .touchUpInside)
                break
            case SalaryType.biWeekly.id:
                btnBiWeekly.sendActions(for: .touchUpInside)
                break
            case SalaryType.monthly.id:
                btnMonthly.sendActions(for: .touchUpInside)
                break
            default:
                break
                
            }
            
            etCompanyName.text = incomeObj?.companyName
            etCompanyNumber.text = incomeObj?.companyContactNumber
            etCompanyAddress.text = incomeObj?.companyAddress
            
            etAmount.text = "\(incomeObj?.amountInDollars ?? 0)"
        }
    }
    
    fileprivate func registerObservers() {
        incomeViewModel.incomeProfileCreated.observe(on: MainScheduler.instance)
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
                                AlertPopupService.sharedInstance.showAlert(inVC: self,alertDescription: "Your income profile is updated successfully", buttonTitle: Constants.buttonOkTxt, completionButtonClick: {
                                    self.navigationController?.popViewController(animated: true)
                                })
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
    
    private func showAlertDialog(errorMsg : String){
        AlertPopupService.sharedInstance.showAlert(inVC: self,alertDescription: errorMsg, buttonTitle: Constants.buttonOkTxt, completionButtonClick: {
            
        })
    }
    
    private func setUI() {
        btnEmployed.setImage(Images.RADIO_ENABLED, for: .selected)
        btnEmployed.setImage(Images.RADIO_DISABLED, for: .normal)
        
        btnRetired.setImage(Images.RADIO_ENABLED, for: .selected)
        btnRetired.setImage(Images.RADIO_DISABLED, for: .normal)
        
        btnSelfEmp.setImage(Images.RADIO_ENABLED, for: .selected)
        btnSelfEmp.setImage(Images.RADIO_DISABLED, for: .normal)
        
        btnUnEmp.setImage(Images.RADIO_ENABLED, for: .selected)
        btnUnEmp.setImage(Images.RADIO_DISABLED, for: .normal)
        
        
        btnWeekly.setImage(Images.RADIO_ENABLED, for: .selected)
        btnWeekly.setImage(Images.RADIO_DISABLED, for: .normal)
        
        btnBiWeekly.setImage(Images.RADIO_ENABLED, for: .selected)
        btnBiWeekly.setImage(Images.RADIO_DISABLED, for: .normal)
        
        btnMonthly.setImage(Images.RADIO_ENABLED, for: .selected)
        btnMonthly.setImage(Images.RADIO_DISABLED, for: .normal)
        
        btnEmployed.isSelected = true
        btnWeekly.isSelected = true
    }
    
    
    @IBAction func actionEmploymentType(_ sender: UIButton) {
        switch (sender) {
        case btnEmployed:
            btnEmployed.isSelected = true
            btnRetired.isSelected = false
            btnUnEmp.isSelected = false
            btnSelfEmp.isSelected = false
            empView.isHidden = false
            salaryTypeView.isHidden = false
            empType = EmploymentType.employed.id
            break
        case btnRetired:
            btnEmployed.isSelected = false
            btnRetired.isSelected = true
            btnUnEmp.isSelected = false
            btnSelfEmp.isSelected = false
            empView.isHidden = true
            salaryTypeView.isHidden = true
            empType = EmploymentType.retired.id
            break
        case btnUnEmp:
            btnEmployed.isSelected = false
            btnRetired.isSelected = false
            btnUnEmp.isSelected = true
            btnSelfEmp.isSelected = false
            empView.isHidden = true
            salaryTypeView.isHidden = true
            empType = EmploymentType.unEmployed.id
            break
        case btnSelfEmp:
            btnEmployed.isSelected = false
            btnRetired.isSelected = false
            btnUnEmp.isSelected = false
            btnSelfEmp.isSelected = true
            empView.isHidden = true
            salaryTypeView.isHidden = false
            empType = EmploymentType.selfEmployed.id
            break
        default:
            break
        }
    }
    
    @IBAction func actionSalaryType(_ sender: UIButton) {
        switch(sender) {
        case btnWeekly:
            btnWeekly.isSelected = true
            btnBiWeekly.isSelected = false
            btnMonthly.isSelected = false
            salaryType = SalaryType.weekly.id
            break
        case btnBiWeekly:
            btnWeekly.isSelected = false
            btnBiWeekly.isSelected = true
            btnMonthly.isSelected = false
            salaryType = SalaryType.biWeekly.id
            break
        case btnMonthly:
            btnWeekly.isSelected = false
            btnBiWeekly.isSelected = false
            btnMonthly.isSelected = true
            salaryType = SalaryType.monthly.id
            break
        default:
            break
        }
    }
    
    private func validateInput () -> Bool {
        if(btnEmployed.isSelected) {
            if etCompanyName.text!.removeLeadingAndTrailingSpaces().isEmpty {
                alertMsg = Constants.kAddCompName
                return false
            } else if etCompanyNumber.text!.removeLeadingAndTrailingSpaces().isEmpty {
                alertMsg = Constants.kAddCompNumber
                return false
            } else if etCompanyAddress.text!.removeLeadingAndTrailingSpaces().isEmpty {
                alertMsg = Constants.kAddCompAddress
                return false
            } else if etAmount.text!.isEmpty {
                alertMsg = Constants.kAddSalary
                return false
            }
        } else if (btnSelfEmp.isSelected) {
            if etAmount.text!.isEmpty {
                alertMsg = Constants.kAddSalary
                return false
            }
        }
        return true
    }
    
    func saveIncomeProfile () {
        incomeViewModel.createIncomeProfile(requestModel: CreateIncomeProfileRequestModel(employementType: empType, salaryType: salaryType, userUid: UserDefaultsHandler.sharedInstance.getMyUserObj()?.uid ?? "", companyName: etCompanyName.text ?? "", companyAddress: etCompanyAddress.text ?? "", companyContactNumber: etCompanyNumber.text ?? "", amountInDollars: (etAmount.text as? NSString)?.integerValue ?? 0))
    }
    
    func updateIncomeProfile() {
        incomeViewModel.updateIncomeProfile(requestModel: UpdateIncomeProfileRequestModel(employementType: empType, salaryType: salaryType, uid: incomeObj!.uid, userUid: UserDefaultsHandler.sharedInstance.getMyUserObj()?.uid ?? "", companyName: etCompanyName.text ?? "", companyAddress: etCompanyAddress.text ?? "", companyContactNumber: etCompanyNumber.text ?? "", amountInDollars: (etAmount.text as? NSString)?.integerValue ?? 0))
    }
    
    @IBAction func actionButtonPress(_ sender: UIButton) {
        switch (sender) {
        case btnSave:
            if validateInput() {
                if (incomeObj != nil) {
                    updateIncomeProfile()
                } else {
                    saveIncomeProfile()
                }
                
            } else {
                showAlertDialog(errorMsg: alertMsg)
            }
            break
        case btnBack:
            self.navigationController?.popViewController(animated: true)
            break
        default:
            break
        }
    }
}
