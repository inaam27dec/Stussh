//
//  Constants.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 8/22/23.
//

import Foundation
import UIKit

struct Colors {
    static let APP_PRIMARY_COLOR = UIColor(named: "AppPrimaryColor")
    static let APP_SECONDARY_COLOR = UIColor(named: "AppSecondaryColor")
    static let APP_DARK_GRAY_COLOR = UIColor(named: "AppDarkGrayColor")
    static let CELL_ENABLED_COLOR = UIColor(named: "cellEnabledColor")
    static let CELL_DISABLED_COLOR = UIColor(named: "cellDisabledColor")
    static let APP_GRAY_COLOR = UIColor(named: "AppGrayColor")
    static let USERS_BLUE_COLOR = UIColor(named: "UsersBlueColor")

    
    
    static let white = UIColor.white
    static let BLACK = UIColor.black
    static let APP_FIELD = UIColor(hex: "#F9F9F9")
    static let GRAY = #colorLiteral(red: 0.9098039216, green: 0.9176470588, blue: 0.9333333333, alpha: 1)
//    static let PINK_THEME_COLOR = UIColor(named: "PinkColor")
    static let APP_BLUE = UIColor(hex: "#16479C")
    static let GRADIENT_BLUE = UIColor(named: "GradientBlue")
    static let GRADIENT_PINK = UIColor(named: "GradientPink")
    static let CUSTOM_GRAY = UIColor(named: "CustomGray")
    static let CUSTOM_LIGHT_GRAY = UIColor(named: "CustomLightGray")
    static let CUSTOM_DARK_GRAY = UIColor(named: "CustomDarkGray")
    static let PINK_THEME_COLOR = UIColor(named: "PinkThemeColor")
    static let APP_FIELD_BORDER_COLOR = UIColor(named: "AppFieldBorderColor")
    static let BORDER_COLOR = UIColor(named: "BorderColor")
}

struct Images {
    static let PRIMARY_ENABLED = UIImage(named: "ic_primary_enable")
    static let PRIMARY_DISABLED = UIImage(named: "ic_primary_disable")
    static let CHECKBOX_ENABLED = UIImage(named: "ic_checkbox_selected")
    static let CHECKBOX_DISABLED = UIImage(named: "ic_checkbox_unselected")
    
    static let RADIO_ENABLED = UIImage(named: "ic_radiobutton_on")
    static let RADIO_DISABLED = UIImage(named: "ic_radiobutton_off")
}

struct Storyboards {
    static let MAIN =  UIStoryboard(name: "Main", bundle: nil)
    static let POPUP = UIStoryboard(name: "AlertsBoard", bundle: nil)
    static let AUTHENTICATION =  UIStoryboard(name: "Authentication", bundle: nil)
    static let PROFILE =  UIStoryboard(name: "Profile", bundle: nil)
    static let OTHER =  UIStoryboard(name: "Other", bundle: nil)
    static let CrowdSavingsAlerts = UIStoryboard(name: "CrowdSavingsAlerts", bundle: nil)
    static let SAVING_HUB = UIStoryboard(name: "SavingHub", bundle: nil)
}

struct NameValueObj {
    let name : String
    let id: Int
}

struct SalaryType {
    static let weekly = NameValueObj(name: "Weekly", id: 1)
    static let biWeekly = NameValueObj(name: "Bi-Weekly", id: 2)
    static let monthly =  NameValueObj(name: "Monthly", id: 3)
    
}

struct EmploymentType {
    static let employed = NameValueObj(name: "Employed", id: 1)
    static let selfEmployed = NameValueObj(name: "Self Employed", id: 2)
    static let retired =  NameValueObj(name: "Retired", id: 3)
    static let unEmployed = NameValueObj(name: "Unemployed", id: 4)
}

struct SelectionTab {
    static let PERSONAL_PROFILE = 1
    static let BANK_PROFILE = 2
    static let INCOME_PROFILE = 3
}

struct Constants{
    static let APP_NAME = "Stush App"
    static let NO_INTERNET:String = "Internet Not Available"
    static let kSkip = "Skip"
    static let kSettings = "Settings"
    static let kZAAMApp = "ZAAM Consumer App"
    static let kCancel = "Cancel"
    static let kYes = "Yes"
    static let kNo = "No"
    static let kOk = "OK"
    static let kWait = "Hey, Wait!!!"
    static let kLogout = "Are you sure you want to logout?"
    static let kFields = "Please fill all the required fields."
    static let kValidEmail = "Please enter a valid email."
    static let kSelectDOB = "Please select your date of birth."
    
    static let kPasswordValidation = "The password must contains minimum of 8 characters and at least 1 uppercase alphabet, 1 lowercase alphabet and 1 number."
    static let kConfirmPassword = "The password does not match. Please confirm."
    static let kInvalidPassword = "The password is invalid. Please confirm."
    static let kInvalidPhoneNumber = "Please enter valid phone number."
    static let kSuccessfullRegistration = "Congratulations. You have been successfully registered!"
    static let kLinkSent = "Link has been sent to your email."
    static let kEnterPassword = "Please enter your password."
    static let kEnterFirstName = "Please enter your first name"
    static let kEnterLastName = "Please enter your last name"
    static let kEnterEmail = "Please enter your email."
    static let kEnterPhoneNumber = "Please enter your phone number to continue."
    static let kAddProfilePic = "Please add profile picture before proceeding."
    
    static let kAddBankName = "Please add bank name"
    static let kAddBankNumber = "Please add your bank account number"
    static let kAddValidBankNumber = "Invalid IBAN number. Please add valid IBAN Number"
    static let kAddRoutingNumber = "Please add you ACH routing number"
    
    static let kAddCompName = "Please add company name"
    static let kAddCompNumber = "Please add company number"
    static let kAddCompAddress = "Please add company address"
    static let kAddSalary = "Please add your salary in Dollars"
    
    static let kDeleteAddressConfirmation = "Are you sure you want to delete the address?"
    static let kAddressCreated = "Address has been created successfully."
    static let kAddressUpdated = "Address has been updated successfully."
    static let kWhatsAppInstallation = "WhatsApp is not installed on your device."
    static let Service = "USER INFO SERVICE"
    static let kSessionExpiredMessage = "Session Expired. Please re-login to proceed."
    static let kCartId = "cartId"
    static let GOOGLE_MAPS_API_KEY:String = "AIzaSyCWxc2L_6hVxV2PeXdDtxm52F3pImIwrmM"
    static let kUnknownError = "An unknown error occured. Please try again."
    static let kNoBillingAddress = "No billing address found. Please set a billing address to proceed further."
    static let kNoShippingAddress = "Please enter your home address"
    static let kNoCity = "Please enter your city"
    static let kNoState = "Please enter your state"
    static let kNoZipCode = "Please enter your zip code"
    static let kNoSSN = "Please enter your social security number (SSN)."
    static let kInvalidSSN = "Invalid social security number (SSN)."
    static let kFailed = "Server is not responding. Please try again later"
    
    static let kAreYouSure = "Are you sure?"
    static let kTopTech = "Top Tech"
    static let kPaymentMethod = "stripe_payments"
    static let kSuccessResponse = "success"
    static let kErrorResponse = "Error"
    static let kEmptyResponseError = "No Data Found"
    static let kEmptyShippingAddress = "No default Shipping Address found. Please create before proceeding."
    static let kEmptyBillingAddress = "No default Billing Address found. Please create one or bill from an already existing address."
    static let kBillingNotSelected = "No default Billing Address found. Please select a billing address to proceed."
    static let kInvalidCountrySelected = "Currently we are only operating in UAE. Please select UAE to continue payment."
    static let kEndSubscriptionPeriodDisabledAlertTitle = "End of Subscription Pick-up"
    static let kEndSubscriptionPeriodDisabledAlertSubtitle = "This feature will be enabled 2 weeks before the end of your subscription to schedule a pick-up date and time."
    static let kEmailInvoiceConfirmationMessage = "Would you like to send a copy of this invoice to "
    static let completeProfileInfoTxt = "You need to add your Banking Information and Salary Information before selecting any crowd saving program. Complete your profile and try again later."
    
    static let buttonCompleteProfileTxt = "Complete Profile"
    static let buttonOkTxt = "Okay"
    
    static let alertCannotDeleteEditBank = "You cannot edit / delete the bank information as the bank is currently being used for a crowd saving program. Once that program will be finished you can edit / delete this account."
    static let alertDeleteConfirmation = "Are you sure, want to delete this bank account?"
    
    static let alertLogoutConfirmation = "Are you sure, you want to logout?"
    
    static let alertDeleteUserConfirmation = "Are you sure to delete your account. By Pressing YES all the user informations will be lost and your account will be deleted permanently"
    
    static let alertCannotDeletePrimary = "You cannot delete the bank information as the bank is currently used as primary bank."
    
    static let profileUpdateSuccessfully = "Your profile has been updated successfully."
    
    static let alertCardActivatedSuccess = "Your STUSH Debit card has been activated successfully. You can use this card for online shopping as well as for POS."
    static let savingHubJoiningxt = "If you prefer to join a current program, visit the Savings Hub"
    static let termsAndConditions = "terms and conditions"
    static let termsAndConditionsMandatoryCheckError = "You must agree to the terms and conditions before proceeding forward"
    static let mandatoryFieldsError = "Please fill the mandatory fields and try again"
    
    static let comingSoon = "This feature is coming soon alongwith many more updates. Stay tuned!!!"
}

