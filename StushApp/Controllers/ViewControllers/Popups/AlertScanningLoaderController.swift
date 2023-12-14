//
//  AlertScanningLoaderController.swift
//  StushApp
//
//  Created by Moiz Farasat on 21/09/2023.
//

import UIKit

class AlertScanningLoaderController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.dismiss(animated: true, completion: {
                Router.shared.showCrowdSavingAvailableOptionsDialog(inViewController: self)
            })
        })
    }

}
