//
//  AppButton.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 8/25/23.
//

import UIKit

class PinkBoldButton: UIButton {
    
    func setupView() {
        setTitleColor(Colors.white, for: .normal)
        backgroundColor = Colors.APP_PRIMARY_COLOR
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
}
