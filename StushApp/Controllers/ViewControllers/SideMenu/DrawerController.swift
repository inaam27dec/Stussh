//
//  DrawerController.swift
//  zaamConsumerApp
//
//  Created by Moiz Ahmed on 06/05/2023.
//

import UIKit
import LGSideMenuController

class DrawerController: LGSideMenuController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        rootViewController = Storyboards.MAIN.instantiateViewController(withIdentifier: DashboardViewController.className)
        leftViewController = Storyboards.MAIN.instantiateViewController(withIdentifier: "SideMenuNavigationController")
       // rightViewController = Storyboards.CART.instantiateViewController(withIdentifier: MiniCartController.className)
        //rightViewWidth = view.frame.width - 30
        leftViewWidth = 275
        }
    }
