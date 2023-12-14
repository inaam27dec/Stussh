//
//  DrawerItemModel.swift
//  zaamConsumerApp
//
//  Created by Adeel Tahir on 23/06/2022.
//

import Foundation
import UIKit

struct DrawerItemModel {
    let title: String
    let image: UIImage
    let type: DrawerItemType
}

enum DrawerItemType: String {
    case Profile = "Profile"
    case SavingHub = "Saving Hub"
    case StushDebitCard = "Stush Debit Card"
    case TransactionHistory = "Transaction History"
    case ChangePassword = "Change Password"
    case DeleteAccount = "Delete Account"
    case ContactUs = "Contact Us"
    case Logout = "Log out"
}
