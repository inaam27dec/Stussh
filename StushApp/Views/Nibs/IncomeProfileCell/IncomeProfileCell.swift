//
//  IncomeProfileCell.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 9/14/23.
//

import UIKit

class IncomeProfileCell: UITableViewCell {
    
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var amountView: UIStackView!
    @IBOutlet weak var lblSalaryType: UILabel!
    @IBOutlet weak var salaryTypeView: UIStackView!
    @IBOutlet weak var lblCompanyContactNumber: UILabel!
    @IBOutlet weak var companyContactView: UIStackView!
    @IBOutlet weak var lblCompanyAddress: UILabel!
    @IBOutlet weak var companyAddressView: UIStackView!
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var companyNameView: UIStackView!
    @IBOutlet weak var lblEmpType: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(obj: Income) {
        switch (obj.employementType) {
        case EmploymentType.employed.id:
            lblEmpType.text = EmploymentType.employed.name
            lblCompanyName.text = obj.companyName
            lblCompanyAddress.text = obj.companyAddress
            lblCompanyContactNumber.text = obj.companyContactNumber
            lblSalaryType.text = setSalaryType(salaryType: obj.salaryType)
            lblAmount.text = "$\(obj.amountInDollars)"
            
            amountView.isHidden = false
            salaryTypeView.isHidden = false
            companyNameView.isHidden = false
            companyAddressView.isHidden = false
            companyContactView.isHidden = false
            break
        case EmploymentType.retired.id:
            lblEmpType.text = EmploymentType.retired.name
            lblSalaryType.text = setSalaryType(salaryType: obj.salaryType)
            lblAmount.text = "$\(obj.amountInDollars)"
            
            amountView.isHidden = false
            salaryTypeView.isHidden = true
            companyNameView.isHidden = true
            companyAddressView.isHidden = true
            companyContactView.isHidden = true
            
            break
        case EmploymentType.selfEmployed.id:
            lblEmpType.text = EmploymentType.selfEmployed.name
            lblSalaryType.text = setSalaryType(salaryType: obj.salaryType)
            lblAmount.text = "$\(obj.amountInDollars)"
            
            amountView.isHidden = false
            salaryTypeView.isHidden = false
            companyNameView.isHidden = true
            companyAddressView.isHidden = true
            companyContactView.isHidden = true
            break
        case EmploymentType.unEmployed.id:
            lblEmpType.text = EmploymentType.unEmployed.name
            amountView.isHidden = true
            salaryTypeView.isHidden = true
            companyNameView.isHidden = true
            companyAddressView.isHidden = true
            companyContactView.isHidden = true
            break
        default:
            break
        }
        
    }
    
    
    private func setSalaryType (salaryType : Int) -> String {
        var salType = ""
        switch (salaryType) {
        case SalaryType.weekly.id:
            salType = SalaryType.weekly.name
            break
        case SalaryType.biWeekly.id:
            salType = SalaryType.biWeekly.name
            break
        case SalaryType.monthly.id:
            salType = SalaryType.monthly.name
            break
        default:
            break
            
        }
        
        return salType
    }
    
    
}
