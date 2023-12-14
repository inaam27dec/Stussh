//
//  SignUpFormCell.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 9/8/23.
//

import UIKit



class SignUpFormCell: UITableViewCell {

    var CallVConButtonClick: ((_ sender: UIButton) -> ())?
    @IBOutlet weak var ivShowConfirmPass: UIImageView!
    @IBOutlet weak var ivShowPass: UIImageView!
    @IBOutlet weak var etConfirmPass: UITextField!
    @IBOutlet weak var etPassword: UITextField!
    @IBOutlet weak var etSSN: UITextField!
    @IBOutlet weak var etShippingAddress: UITextField!
    @IBOutlet weak var etDOB: UITextField!
    @IBOutlet weak var etEmailAddress: UITextField!
    @IBOutlet weak var etLastName: UITextField!
    @IBOutlet weak var etFirstName: UITextField!
    @IBOutlet weak var btnShowConfirmPassword: UIButton!
    @IBOutlet weak var btnShowPassword: UIButton!
    @IBOutlet weak var btnLoginNow: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnUploadImage: UIButton!
    @IBOutlet weak var photoView: UIView!
    @IBOutlet weak var etState: UITextField!
    @IBOutlet weak var ivProfilePic: UIImageView!
    @IBOutlet weak var etCity: UITextField!
    @IBOutlet weak var etZipCode: UITextField!
    @IBOutlet weak var btnReUpload: UIButton!
    var finalDOB : String = ""
    let datePicker = UIDatePicker()
    @IBOutlet weak var btnSelectState: UIButton!
    
    
    private var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDatePickerView()
    }
    
    
    @IBAction func actionButtonPress(_ sender: UIButton) {
        CallVConButtonClick?(sender)
    }
    
}

extension SignUpFormCell {
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
        etDOB.text = formatter.string(from: datePicker.date)
        finalDOB = "\(etDOB.text ?? "")T00:00:00.000Z"
        self.contentView.endEditing(true)
    }

    @objc private func cancelDatePicker(){
        self.contentView.endEditing(true)
    }
}
