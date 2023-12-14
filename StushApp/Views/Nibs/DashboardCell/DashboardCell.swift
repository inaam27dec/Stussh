//
//  DashboardCell.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 9/4/23.
//

import UIKit

class DashboardCell: UICollectionViewCell {

    @IBOutlet weak var btnComingSoon: UIButton!
    @IBOutlet weak var vBackground: UIView!
    @IBOutlet weak var lblProgramName: UILabel!
    var CallVConButtonClick: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func actionCellClick(_ sender: UIButton) {
        CallVConButtonClick?()
    }
    
    func setData (programName: String){
        self.lblProgramName.text = programName
    }
    
}
