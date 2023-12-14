//
//  CustomNavigationController.swift
//  zaamConsumerApp
//
//  Created by Adeel Tahir on 27/04/2022.
//

import UIKit
import RxSwift
class CustomNavigationController: UINavigationController {
    
    
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func configureNavBar(withMenuButton showMenuButton: Bool = false) {
        if let topController = self.topViewController {
            
            //topController.navigationItem.titleView = UIImageView(image: UIImage(named: "homeLogo"))
                                    
            if showMenuButton {
                let leftBarButton = UIBarButtonItem()
                leftBarButton.image = UIImage(named: "navMenuIcon")
                leftBarButton.action = #selector(actionMenuDrawer)
//                topController.navigationItem.leftBarButtonItem = leftBarButton
                topController.navigationItem.leftBarButtonItems = [leftBarButton]
            } else {
                let leftBarButton = UIBarButtonItem()
                leftBarButton.image = UIImage(named: "ic_back")
                leftBarButton.action = #selector(actionBackNavigation)
                topController.navigationItem.leftBarButtonItem = leftBarButton
            }

        }
    }
    
//    func configureNavBar(withMenuButton showMenuButton: Bool = false, andTitle title:String, andShowCart showCart: Bool = true) {
//        if let topController = self.topViewController {
//
//            //topController.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.CUSTOM_GRAY!, NSAttributedString.Key.font: Fonts.DMSans.Medium16!]
//            topController.navigationItem.title = title
//
//            if showCart {
//                let navButtonView = UIView(frame: CGRect(x: 0, y: 0, width: 39, height: 44))
//                navButtonView.backgroundColor = UIColor.clear
//
//                let button = UIButton(type: UIButton.ButtonType.system)
//                button.frame = navButtonView.bounds
//                button.backgroundColor = .clear
//                button.setImage(UIImage(named: "navCartIcon"), for: .normal)
//                button.addTarget(self, action: #selector(actionBtnCart), for: .touchUpInside)
//
//                navButtonView.addSubview(button)
//
//                navButtonView.addSubview(self.cartCounterView)
//
//                let rightBarButton = UIBarButtonItem()
//                rightBarButton.customView = navButtonView
//                topController.navigationItem.rightBarButtonItem = rightBarButton
//            }
//
//            if showMenuButton {
//                let leftBarButton = UIBarButtonItem()
//                leftBarButton.image = UIImage(named: "navMenuIcon")
//                leftBarButton.action = #selector(actionMenuDrawer)
////                topController.navigationItem.leftBarButtonItem = leftBarButton
//                topController.navigationItem.leftBarButtonItems = [leftBarButton]
//            } else {
//                let leftBarButton = UIBarButtonItem()
//                leftBarButton.image = UIImage(named: "back_arrow")
//                leftBarButton.action = #selector(actionBackNavigation)
//                topController.navigationItem.leftBarButtonItem = leftBarButton
//            }
//        }
//    }
    
    @objc func actionBackNavigation() {
        popViewController(animated: true)
    }
    
    @objc func actionMenuDrawer() {
        if let window = AppDelegate.appDelegate().window, let drawerMenu = window.rootViewController as? DrawerController {
            drawerMenu.showLeftView()
        }
    }
    
}
