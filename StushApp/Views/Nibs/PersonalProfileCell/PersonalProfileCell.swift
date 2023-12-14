//
//  PersonalProfileCell.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 9/14/23.
//

import UIKit

class PersonalProfileCell: UITableViewCell {
    
    @IBOutlet weak var ivProfilePic: UIImageView!
    @IBOutlet weak var etDOB: UILabel!
    @IBOutlet weak var etSSN: UILabel!
    @IBOutlet weak var ethomeAddress: UILabel!
    @IBOutlet weak var etEmailAddress: UILabel!
    @IBOutlet weak var etFullName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setProfileData (obj : ProfileDataClass?) {
        if obj != nil {
            if let profileImageString = obj!.profileImage, !profileImageString.isEmpty {
                if let image = profileImageString.convertBase64ToImage() {
                    ivProfilePic.image = image
                }
            }
            etFullName.text = "\(obj!.firstName) \(obj!.lastName)"
            etEmailAddress.text = obj!.email
            ethomeAddress.text = setUserAddress(profileObj: obj)
            etSSN.text = obj!.ssn
            if let localDate = obj!.dob.convertUTCDateStringToLocalDateString() {
                etDOB.text = localDate
            }
        }
    }
    
    func setUserAddress(profileObj : ProfileDataClass?) -> String {
        var address = ""
        if (profileObj != nil) {
            address = "\(profileObj?.shippingAddress ?? ""), \(profileObj?.city ?? ""), \(profileObj?.state ?? ""), \(profileObj?.zipCode ?? "")"
        }
        return address
    }
}
