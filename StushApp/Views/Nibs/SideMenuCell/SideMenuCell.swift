//
//  SideMenuCell.swift
//  zaamConsumerApp
//
//  Created by Monisa Hassan on 3/18/22.
//

import Foundation
import UIKit

class SideMenuCell: UITableViewCell{
    
    @IBOutlet weak var imgMenuItem: UIImageView!
    @IBOutlet weak var lblMenuItem: UILabel!
    @IBOutlet weak var lblMenuItemLeadingConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
