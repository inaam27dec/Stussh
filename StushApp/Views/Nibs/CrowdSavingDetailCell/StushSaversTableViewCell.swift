//
//  StushSaversTableViewCell.swift
//  StushApp
//
//  Created by Moiz Farasat on 23/09/2023.
//

import UIKit

class StushSaversTableViewCell: UITableViewCell {

    @IBOutlet weak var lblNameInitials: UILabel!
    @IBOutlet weak var svNameInitals: UIStackView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
