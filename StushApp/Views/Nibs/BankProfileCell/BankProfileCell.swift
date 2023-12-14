//
//  BankProfileCell.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 9/14/23.
//

import UIKit

class BankProfileCell: UITableViewCell {
    
    weak var bankDelegate: BankProfileDelegates?
    @IBOutlet weak var lblAccountNumber: UILabel!
    @IBOutlet weak var lblBankName: UILabel!
    @IBOutlet weak var btnMakePrimary: UIButton!
    @IBOutlet weak var lblPrimary: UILabel!
    @IBOutlet weak var ivMakePrimary: UIImageView!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    var bankId : String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(obj : Bank){
        lblBankName.text = obj.name
        lblAccountNumber.text = obj.accountNumber
        
        if obj.isPrimary {
            btnMakePrimary.isHidden = true
            lblPrimary.isHidden = false
            ivMakePrimary.image = Images.PRIMARY_ENABLED
        } else {
            btnMakePrimary.isHidden = false
            lblPrimary.isHidden = true
            ivMakePrimary.image = Images.PRIMARY_DISABLED
        }
    }
    
    @IBAction func actionButtonPress(_ sender: UIButton) {
        switch (sender) {
        case btnEdit :
            bankDelegate?.onClickEditBank(bankId: self.bankId)
            break
        case btnDelete:
            bankDelegate?.onClickDeleteBank(bankId: self.bankId)
            break
        case btnMakePrimary:
            bankDelegate?.onClickMakePrimary(bankId: self.bankId)
            break
        default:
            break
        }
    }
}
