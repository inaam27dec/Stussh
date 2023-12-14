//
//  EditPersonalProfileViewController.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 9/15/23.
//

import UIKit
import RxSwift

class EditPersonalProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var etSSN: UITextField!
    @IBOutlet weak var etHomeAddress: UITextField!
    @IBOutlet weak var etDOB: UITextField!
    @IBOutlet weak var etEmailAddress: UITextField!
    @IBOutlet weak var etLastName: UITextField!
    @IBOutlet weak var etFirstName: UITextField!
    @IBOutlet weak var ivProfilePic: UIImageView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnEditProfilePic: UIButton!
    private var alertMsg = ""
    var profilePic : String = ""
    var finalDOB : String = ""
    let datePicker = UIDatePicker()
    var obj : ProfileDataClass?
    
    var profileViewModel = ProfileViewModel.shared
    let bag = DisposeBag()
    
    private var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatePickerView()
        setData()
        registerObservers()
    }
    
    fileprivate func registerObservers() {
        
        profileViewModel.profileUpdated.observe(on: MainScheduler.instance)
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
                                AlertPopupService.sharedInstance.showAlert(inVC: self,alertDescription: Constants.profileUpdateSuccessfully, buttonTitle: Constants.buttonOkTxt, completionButtonClick: {
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
    
    func showAlertDialog(errorMsg : String){
        AlertPopupService.sharedInstance.showAlert(inVC: self,alertDescription: errorMsg, buttonTitle: Constants.buttonOkTxt, completionButtonClick: {
            
        })
    }
    
    
    private func setData(){
        if (obj != nil){
            if obj?.profileImage != "" {
                if let image = obj?.profileImage?.convertBase64ToImage() {
                    profilePic = obj?.profileImage ?? ""
                    ivProfilePic.image = image
                }
            }
            
            if let datePickerDate = obj?.dob.serverDateToDatePickerFormat() {
                finalDOB = datePickerDate
            }
            
            datePicker.setDateFromServerDate(serverDate: obj?.dob ?? "")
            etDOB.text = datePicker.date.formattedDate()
            
            etFirstName.text = (obj?.firstName)
            etLastName.text = (obj?.lastName)
            etEmailAddress.text = obj?.email
            etHomeAddress.text = obj?.shippingAddress
            etSSN.text = obj?.ssn

            
        }
        
    }
    
    func validateInput() -> Bool {
        if profilePic.isEmpty {
            alertMsg = Constants.kAddProfilePic
            return false
        } else if etFirstName.text!.isEmpty {
            alertMsg = Constants.kEnterFirstName
            return false
        } else if etLastName.text!.isEmpty {
            alertMsg = Constants.kEnterLastName
            return false
        }  else if etEmailAddress.text!.isEmpty {
            alertMsg = Constants.kEnterEmail
            return false
        } else if etEmailAddress.text!.isValidEmail == false {
            alertMsg = Constants.kValidEmail
            return false
        } else if etDOB.text!.isEmpty {
            alertMsg = Constants.kSelectDOB
            return false
        } else if etHomeAddress.text!.isEmpty {
            alertMsg = Constants.kNoShippingAddress
            return false
        } else if etSSN.text!.isEmpty {
            alertMsg = Constants.kNoSSN
            return false
        }  else if etSSN.text!.isValidSSN == false {
            alertMsg = Constants.kInvalidSSN
            return false
        }
        return true
    }
    
    func showImagePicker(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary // You can change this to .camera if you want to capture photos
        
        // Present the image picker
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // Set the selected image to your UIImageView
            ivProfilePic.image = pickedImage
            self.showLoader()
            ImageCompressor.compress(image: pickedImage, maxByte: 10000) { image in
                guard let compressedImage = image else { return }
                // Use compressedImage
                if let base64String = compressedImage.toBase64() {
                    self.profilePic = base64String
                    self.hideLoader()
                }
            }
            
        }
        // Dismiss the image picker
        picker.dismiss(animated: true, completion: nil)
    }

    @IBAction func actionButtonPress(_ sender: UIButton) {
        switch(sender) {
        case btnEditProfilePic:
            showImagePicker()
            break
        case btnSave:
            if validateInput() {
                var finalReqObj =  EditProfileRequestModel(uid: obj?.uid ?? "", firstName: etFirstName.text ?? "", lastName: etLastName.text ?? "", phoneNumber: "", shippingAddress: etHomeAddress.text ?? "", ssn: etSSN.text ?? "", dob: "\(finalDOB.split(separator: "T")[0])T00:00:00.000Z", isProfileCompleted: obj?.isProfileCompleted ?? false, hasJoinedAnyProgram: obj?.hasJoinedAnyProgram ?? false, profileImage: profilePic, city: obj?.city ?? "", state: obj?.state ?? "", zipCode: obj?.zipCode ?? "")
                
                profileViewModel.updateUserProfile(requestModel: finalReqObj)
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

extension EditPersonalProfileViewController {
    private func setupDatePickerView() {
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        let currentDate = Date()

        // Calculate the date for yesterday
        let calendar = Calendar.current
        if let yesterday = calendar.date(byAdding: .day, value: -1, to: currentDate) {
            // Set the minimum date of the date picker to yesterday
            datePicker.maximumDate = yesterday
        }

        let toolbar  = UIToolbar()
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([doneButton, spaceButton, cancelButton], animated: false)

        etDOB.inputAccessoryView = toolbar
        etDOB.inputView = datePicker
    }

    @objc private func donedatePicker(){
        
        etDOB.text = datePicker.date.formattedDate()
        finalDOB = "\(datePicker.date.toServerDateString().split(separator: "T")[0])T00:00:00.000Z"
        self.view.endEditing(true)
    }

    @objc private func cancelDatePicker(){
        self.view.endEditing(true)
    }
}
