//
//  UITableViewCell+Extension.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 8/22/23.
//

import Foundation

import UIKit

public extension UITableViewCell {
    
    /// The color of the cell when it is selected.
    @objc dynamic var selectionColor: UIColor? {
        get { return selectedBackgroundView?.backgroundColor }
        set {
            guard selectionStyle != .none else { return }
            selectedBackgroundView = UIView().with {
                $0.backgroundColor = newValue
            }
        }
    }
    
    func addShadowToCellInTableView(lastIndex: Int, atIndexPath indexPath: IndexPath!) {
        let isLastRow: Bool = (indexPath.row == lastIndex - 1)
        guard let backgroundView = self.backgroundView else { return }
        ConsumerAppUtility.addShadowAlongMultipleRows(toView: backgroundView, rowType: isLastRow ? RowType.lastRow : RowType.midRow)
    }
    
    func addShadowToSingleCell() {
        
        guard let backgroundView = self.backgroundView else { return }
        ConsumerAppUtility.addShadowAlongSingleRow(toView: backgroundView)
    }
}
