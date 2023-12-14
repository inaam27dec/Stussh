//
//  ProfileViewController.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 9/14/23.
//

import UIKit
import RxSwift

class ProfileViewController: UIViewController, BankProfileDelegates {
    
    @IBOutlet weak var lblNoData: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnBottom: UIButton!
    @IBOutlet weak var tblProfile: UITableView!
    @IBOutlet weak var btnSalaryProfile: UIButton!
    @IBOutlet weak var btnBankProfile: UIButton!
    @IBOutlet weak var btnPersonalProfile: UIButton!
    private var selectedTab = SelectionTab.PERSONAL_PROFILE
    private var incomeObj : Income?
    private var banksList : [Bank] = []
    private var profileResponse: ProfileDataClass?
    var profileViewModel = ProfileViewModel.shared
    var bankViewModel = BankViewModel.shared
    let bag = DisposeBag()
    var itemCount = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        registerObservers()
    }
    
    fileprivate func registerObservers() {
        
        bankViewModel.bankDeleted.observe(on: MainScheduler.instance)
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
                                profileViewModel.fetchUserProfiles()
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
                                profileViewModel.fetchUserProfiles()
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
        
        
        profileViewModel.myProfileData.observe(on: MainScheduler.instance)
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
                                if let profileObj = element.data?.data {
                                    profileResponse = profileObj
                                    
                                    if let bankAccountsList = profileResponse?.banks {
                                        if bankAccountsList.count > 0 {
                                            banksList = bankAccountsList
                                        } else {
                                            banksList = []
                                        }
                                    }
                                    
                                    if let incomeProfile = profileResponse?.income {
                                        incomeObj = incomeProfile
                                    }
                                    
                                    var obj = UserDefaultsHandler.sharedInstance.getMyUserObj()
                                    
                                    obj?.isProfileCompleted = profileObj.isProfileCompleted
                                    obj?.firstName = profileObj.firstName
                                    obj?.lastName = profileObj.lastName
                                    obj?.email = profileObj.email
                                    obj?.hasJoinedAnyProgram = profileObj.hasJoinedAnyProgram
                                    
                                    UserDefaultsHandler.sharedInstance.saveMyUserObj(obj: obj!)
                                    
                                    setUIThings()
                                    
                                    tblProfile.reloadData()
                                }
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
    
    private func setUIThings() {
        switch(selectedTab){
        case SelectionTab.PERSONAL_PROFILE:
            btnBottom.setTitle("Edit", for: .normal)
            itemCount = 1
            lblNoData.isHidden = true
            break
        case SelectionTab.BANK_PROFILE:
            btnBottom.setTitle("Add New Bank", for: .normal)
            itemCount = banksList.count
            if itemCount == 0 {
                lblNoData.isHidden = false
                lblNoData.text = "You need to setup your\nbank information"
            } else {
                lblNoData.isHidden = true
            }
            break
        case SelectionTab.INCOME_PROFILE:
            itemCount = incomeObj != nil ? 1 : 0
            if itemCount == 0 {
                lblNoData.isHidden = false
                lblNoData.text = "You need to setup your\nincome profile"
                btnBottom.setTitle("Add Income Profile", for: .normal)
            } else {
                lblNoData.isHidden = true
                btnBottom.setTitle("Edit", for: .normal)
            }
            break
        default:
            break
        }
        tblProfile.reloadData()
        
    }
    
    func setupTableView(){
        lblNoData.isHidden = true
        tblProfile.delegate = self
        tblProfile.dataSource = self
        
        tblProfile.register(UINib(nibName: PersonalProfileCell.className, bundle: nil), forCellReuseIdentifier: PersonalProfileCell.className)
        
        tblProfile.register(UINib(nibName: BankProfileCell.className, bundle: nil), forCellReuseIdentifier: BankProfileCell.className)
        
        tblProfile.register(UINib(nibName: IncomeProfileCell.className, bundle: nil), forCellReuseIdentifier: IncomeProfileCell.className)
        
        tblProfile.separatorColor = .clear
        tblProfile.allowsSelection = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileViewModel.fetchUserProfiles()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func actionButtonPress(_ sender: UIButton) {
        switch (sender) {
        case btnSalaryProfile:
            btnSalaryProfile.borderColor = .clear
            btnSalaryProfile.backgroundColor = Colors.APP_SECONDARY_COLOR
            btnSalaryProfile.setTitleColor(.black, for: .normal)
            btnSalaryProfile.borderWidth = 0.0
            
            btnBankProfile.borderColor = Colors.APP_DARK_GRAY_COLOR
            btnBankProfile.backgroundColor = .clear
            btnBankProfile.setTitleColor(Colors.APP_DARK_GRAY_COLOR, for: .normal)
            btnBankProfile.borderWidth = 1.0
            
            btnPersonalProfile.borderColor = Colors.APP_DARK_GRAY_COLOR
            btnPersonalProfile.backgroundColor = .clear
            btnPersonalProfile.setTitleColor(Colors.APP_DARK_GRAY_COLOR, for: .normal)
            btnPersonalProfile.borderWidth = 1.0
            selectedTab = SelectionTab.INCOME_PROFILE
            setUIThings()
            break
        case btnBankProfile:
            btnBankProfile.borderColor = .clear
            btnBankProfile.backgroundColor = Colors.APP_SECONDARY_COLOR
            btnBankProfile.setTitleColor(.black, for: .normal)
            btnBankProfile.borderWidth = 0.0
            
            btnPersonalProfile.borderColor = Colors.APP_DARK_GRAY_COLOR
            btnPersonalProfile.backgroundColor = .clear
            btnPersonalProfile.setTitleColor(Colors.APP_DARK_GRAY_COLOR, for: .normal)
            btnPersonalProfile.borderWidth = 1.0
            
            btnSalaryProfile.borderColor = Colors.APP_DARK_GRAY_COLOR
            btnSalaryProfile.backgroundColor = .clear
            btnSalaryProfile.setTitleColor(Colors.APP_DARK_GRAY_COLOR, for: .normal)
            btnSalaryProfile.borderWidth = 1.0
            
            selectedTab = SelectionTab.BANK_PROFILE
            setUIThings()
            break
        case btnPersonalProfile:
            btnPersonalProfile.borderColor = .clear
            btnPersonalProfile.backgroundColor = Colors.APP_SECONDARY_COLOR
            btnPersonalProfile.setTitleColor(.black, for: .normal)
            btnPersonalProfile.borderWidth = 0.0
            
            btnBankProfile.borderColor = Colors.APP_DARK_GRAY_COLOR
            btnBankProfile.backgroundColor = .clear
            btnBankProfile.setTitleColor(Colors.APP_DARK_GRAY_COLOR, for: .normal)
            btnBankProfile.borderWidth = 1.0
            
            btnSalaryProfile.borderColor = Colors.APP_DARK_GRAY_COLOR
            btnSalaryProfile.backgroundColor = .clear
            btnSalaryProfile.setTitleColor(Colors.APP_DARK_GRAY_COLOR, for: .normal)
            btnSalaryProfile.borderWidth = 1.0
            
            selectedTab = SelectionTab.PERSONAL_PROFILE
            setUIThings()
            break
            
        case btnBottom:
            proceedToBottomAction()
            break
        case btnBack:
            self.navigationController?.popViewController(animated: true)
            break
        default:
            break
        }
    }
    
    private func proceedToBottomAction(){
        switch(selectedTab){
        case SelectionTab.PERSONAL_PROFILE:
            moveToEditProfile()
            break
        case SelectionTab.BANK_PROFILE:
            Router.shared.showBankDialog(inViewController: self, isFromEdit: false, bankObj: nil)
            break
            
        case SelectionTab.INCOME_PROFILE:
            Router.shared.gotoEditIncomeController(inViewController: self, incomeObj: incomeObj)
            break
            
        default:
            break
        }
    }
    
    private func moveToEditProfile(){
        Router.shared.gotoEditProfileScreen(inViewController: self, obj: profileResponse)
    }
    
    func showAlertDialog(errorMsg : String){
        AlertPopupService.sharedInstance.showAlert(inVC: self,alertDescription: errorMsg, buttonTitle: Constants.buttonOkTxt, completionButtonClick: {
        })
    }
    
    func onClickDeleteBank(bankId : String) {
    
        if (profileResponse != nil && profileResponse!.hasJoinedAnyProgram) {
            showAlertDialog(errorMsg: Constants.alertCannotDeleteEditBank)
        } else {
            let delObj =  banksList.filter({$0.uid == bankId}).first
            if(delObj!.isPrimary) {
                showAlertDialog(errorMsg: Constants.alertCannotDeletePrimary)
            } else {
                AlertPopupService.sharedInstance.showAlert(inVC: self,alertDescription: Constants.alertDeleteConfirmation, buttonTitle: Constants.kYes, completionButtonClick: {
                    self.bankViewModel.deleteBank(bankUUID: delObj!.uid)
                },isTwoButton: true)
            }
        }
        
    }
    
    func onClickEditBank(bankId : String) {
        if (profileResponse != nil && profileResponse!.hasJoinedAnyProgram) {
            showAlertDialog(errorMsg: Constants.alertCannotDeleteEditBank)
        } else {
            Router.shared.showBankDialog(inViewController: self, isFromEdit: true, bankObj: banksList.filter({$0.uid == bankId}).first)
        }

    }
    
    func onClickMakePrimary(bankId : String) {
        bankViewModel.markBankAsPrimary(bankUUID: bankId)
    }
}

extension ProfileViewController : UITableViewDelegate, UITableViewDataSource, PopUpDismissDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemCount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return selectedTab != SelectionTab.BANK_PROFILE ? tblProfile.bounds.height : 130
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch (selectedTab) {
        case SelectionTab.PERSONAL_PROFILE:
            let cell = tblProfile.dequeueReusableCell(withIdentifier: PersonalProfileCell.className) as? PersonalProfileCell
            
            if let personalProfileCell = cell {
                personalProfileCell.setProfileData(obj: profileResponse)
                return personalProfileCell
            }
            break
        case SelectionTab.BANK_PROFILE:
            let cell = tblProfile.dequeueReusableCell(withIdentifier: BankProfileCell.className) as? BankProfileCell
            
            if let bankProfileCell = cell {
                bankProfileCell.bankDelegate = self
                bankProfileCell.setData(obj: banksList[indexPath.row])
                bankProfileCell.bankId = banksList[indexPath.row].uid
                return bankProfileCell
            }
            break
        case SelectionTab.INCOME_PROFILE:
            let cell = tblProfile.dequeueReusableCell(withIdentifier: IncomeProfileCell.className) as? IncomeProfileCell
            
            if let incomeProfileCell = cell {
                incomeProfileCell.setData(obj: incomeObj!)
                return incomeProfileCell
            }
            break
            
        default:
            break
        }
        
        return UITableViewCell()
    }
    
    func onControllerReAppear() {
        profileViewModel.fetchUserProfiles()
    }
}
