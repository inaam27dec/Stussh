//
//  SignUpViewController.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 9/8/23.
//

import UIKit
import RxSwift

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    @IBOutlet weak var tblSignUp: UITableView!
    @IBOutlet weak var btnBack: UIButton!
    private var alertMsg : String = ""
    var signUpCell: SignUpFormCell? = nil
    var profilePic : String = ""
    var authenticationViewModel = AuthenticationViewModel.shared
    var commonViewModel = CommonViewModel.shared
    let bag = DisposeBag()
    var finalDOB : String = ""
    let datePicker = UIDatePicker()
    var statesList: [String] = []
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        registerObservers()
        commonViewModel.fetchStates()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
    }
    
    fileprivate func registerObservers() {
        authenticationViewModel.loginData.observe(on: MainScheduler.instance)
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
                                saveUserValues(userInfo: element.data?.data)
                                ModeSelection.instance.loginMode()
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
        
        
        authenticationViewModel.generalData.observe(on: MainScheduler.instance)
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
                                authenticationViewModel.login(requestModel: LoginRequestModel(email: signUpCell!.etEmailAddress.text!, password: signUpCell!.etPassword!.text!))
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
        
        
        commonViewModel.statesResponse.observe(on: MainScheduler.instance)
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
                                setStatesList(list: element.data?.data)
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
    
    func setStatesList (list : [StatesItem]?) {
        if let finalList = list {
            if finalList.count > 0 {
                for state in finalList {
                    statesList.append("\(state.name) (\(state.code))")
                }
            }
        }
    }
    
    func saveUserValues(userInfo: LoginInfo?){
        if(userInfo != nil){
            UserDefaultsHandler.sharedInstance.setLoginToken(token: userInfo?.accessToken ?? "")
            UserDefaultsHandler.sharedInstance.setLoginStatus(isLogin: true)
            UserDefaultsHandler.sharedInstance.saveMyUserObj(obj: userInfo!)
        }
    }
    
    func setTableView(){
        tblSignUp.delegate = self
        tblSignUp.dataSource = self
        tblSignUp.register(UINib(nibName: SignUpFormCell.className, bundle: nil), forCellReuseIdentifier: SignUpFormCell.className)
        tblSignUp.separatorColor = .clear
    }
    
    func togglePassword(isPassword: Bool){
        switch (isPassword) {
        case true:
            if signUpCell!.etPassword.isSecureTextEntry {
                signUpCell!.etPassword.isSecureTextEntry = false
                signUpCell!.ivShowPass.image = UIImage(named: "ic_show_password")
            } else {
                signUpCell!.etPassword.isSecureTextEntry = true
                signUpCell!.ivShowPass.image = UIImage(named: "ic_hide_password")
            }
            break
        case false:
            if signUpCell!.etConfirmPass.isSecureTextEntry {
                signUpCell!.etConfirmPass.isSecureTextEntry = false
                signUpCell!.ivShowConfirmPass.image = UIImage(named: "ic_show_password")
            } else {
                signUpCell!.etConfirmPass.isSecureTextEntry = true
                signUpCell!.ivShowConfirmPass.image = UIImage(named: "ic_hide_password")
            }
            break
        }
    }
    
    func validateInput() -> Bool {
        if profilePic == "" {
            alertMsg = Constants.kAddProfilePic
            return false
        } else if signUpCell!.etFirstName.text!.isEmpty {
            alertMsg = Constants.kEnterFirstName
            return false
        } else if signUpCell!.etLastName.text!.isEmpty {
            alertMsg = Constants.kEnterLastName
            return false
        }  else if signUpCell!.etEmailAddress.text!.isEmpty {
            alertMsg = Constants.kEnterEmail
            return false
        } else if signUpCell!.etEmailAddress.text!.isValidEmail == false {
            alertMsg = Constants.kValidEmail
            return false
        } else if signUpCell!.etDOB.text!.isEmpty {
            alertMsg = Constants.kSelectDOB
            return false
        } else if signUpCell!.etShippingAddress.text!.isEmpty {
            alertMsg = Constants.kNoShippingAddress
            return false
        } else if signUpCell!.etCity.text!.isEmpty {
            alertMsg = Constants.kNoShippingAddress
            return false
        } else if signUpCell!.etState.text!.isEmpty {
            alertMsg = Constants.kNoShippingAddress
            return false
        } else if signUpCell!.etZipCode.text!.isEmpty {
            alertMsg = Constants.kNoShippingAddress
            return false
        } else if signUpCell!.etSSN.text!.isEmpty {
            alertMsg = Constants.kNoSSN
            return false
        }  else if signUpCell!.etSSN.text!.isValidSSN == false {
            alertMsg = Constants.kInvalidSSN
            return false
        } else if signUpCell!.etPassword.text!.isEmpty {
            alertMsg = Constants.kEnterPassword
            return false
        } else if signUpCell!.etPassword.text!.isStrongPassword == false {
            alertMsg = Constants.kPasswordValidation
            return false
        }
        return true
    }
    
    func showAlertDialog(errorMsg : String){
        AlertPopupService.sharedInstance.showAlert(inVC: self,alertDescription: errorMsg, buttonTitle: Constants.buttonOkTxt, completionButtonClick: {
            
        })
    }
    
    func proceedToSignUp() {
        if validateInput() {
            callSignUpAPI()
        } else {
            showAlertDialog(errorMsg: alertMsg)
        }
    }
    
    func callSignUpAPI () {
        let reqObj = SignUpRequestModel(firstName: signUpCell!.etFirstName!.text!.removeLeadingAndTrailingSpaces(), lastName: signUpCell!.etLastName!.text!.removeLeadingAndTrailingSpaces(), email: signUpCell!.etEmailAddress!.text!, password: signUpCell!.etPassword!.text!, phoneNumber: "", shippingAddress: signUpCell!.etShippingAddress!.text!, profileImage: profilePic, ssn: signUpCell!.etSSN!.text!, dob: signUpCell!.finalDOB, city: signUpCell!.etCity.text!, state: signUpCell!.etState.text!, zipCode: signUpCell!.etZipCode.text!)
        
        authenticationViewModel.signUp(requestModel: reqObj)
    }
    
    func showSelectStateDialog(){
        Router.shared.showSelectionDialog(inViewController: self, selectionList: statesList, title: "Select State")
    }
    
    func showImagePicker(){
         // You can change this to .camera if you want to capture photos
        // Present the image picker
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // Set the selected image to your UIImageView
            signUpCell!.btnUploadImage.isHidden = true
            signUpCell!.photoView.isHidden = false
            signUpCell!.ivProfilePic.image = pickedImage
            ImageCompressor.compress(image: pickedImage, maxByte: 10000) { image in
                guard let compressedImage = image else { return }
                // Use compressedImage
                if let base64String = compressedImage.toBase64() {
                    self.profilePic = base64String
                    print("bas64Pic" , self.profilePic)
                }
            }
            
        }
        tblSignUp.reloadData()
        
        // Dismiss the image picker
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionButtonPress(_ sender: UIButton) {
        switch (sender) {
        case btnBack:
            navigationController?.popViewController(animated: true)
            break
        default:
            break
        }
    }
}

extension SignUpViewController : UITableViewDelegate, UITableViewDataSource, ItemSelected {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return signUpCell?.photoView.isHidden ?? false ? 850 : 930
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblSignUp.dequeueReusableCell(withIdentifier: SignUpFormCell.className) as? SignUpFormCell
        
        if let temp = cell {
            signUpCell = temp
            signUpCell!.CallVConButtonClick = { [weak self] (sender) in
                guard let `self` = self else { return }
                onClickHandling(sender: sender)
            }
            
            return signUpCell!
        }
        
        return UITableViewCell()
    }
    
    
    func onClickHandling(sender : UIButton) {
        switch (sender) {
        case signUpCell!.btnShowConfirmPassword:
            togglePassword(isPassword : false)
            break
        case signUpCell!.btnShowPassword:
            togglePassword(isPassword : true)
            break
        case signUpCell!.btnLoginNow:
            navigationController?.popViewController(animated: true)
            break
        case signUpCell!.btnSignUp:
            proceedToSignUp()
            break
        case signUpCell!.btnUploadImage:
            showImagePicker()
            break
        case signUpCell!.btnReUpload:
            showImagePicker()
            break
        case signUpCell?.btnSelectState:
            showSelectStateDialog()
        default:
            break
        }
    }
    
    func onItemSelected(selectedItem: String) {
        signUpCell?.etState.text = selectedItem
    }
}
