//
//  SavingProgramCell.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 9/6/23.
//

import UIKit

class SavingProgramCell: UITableViewCell {

    @IBOutlet weak var btnJoin: UIButton!
    @IBOutlet weak var lblAmountReceived: PaddingLabel!
    @IBOutlet weak var lblProgramTime: PaddingLabel!
    @IBOutlet weak var lblAmountPerWeek: PaddingLabel!
    @IBOutlet weak var lblProgramName: UILabel!
    var CallVConJoinButtonClick: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData (obj: ProgramInfo){
        lblProgramName.text = obj.programName
        lblAmountPerWeek.text = obj.perWeekAmount
        lblProgramTime.text = obj.programTime
        lblAmountReceived.text = obj.receivedAmount
    }
    
    @IBAction func actionJoinButton(_ sender: UIButton) {
        CallVConJoinButtonClick?()
    }
    
    
}
