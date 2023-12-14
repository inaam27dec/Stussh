//
//  AppProtocols.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 9/15/23.
//

import Foundation

protocol BankProfileDelegates : AnyObject {
    func onClickDeleteBank(bankId : String)
    func onClickEditBank(bankId : String)
    func onClickMakePrimary(bankId: String)
}


protocol PopUpDismissDelegate : AnyObject {
    func onControllerReAppear()
}
