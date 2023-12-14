//
//  Router.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 8/22/23.
//

import Foundation
import UIKit

class Router: NSObject {
    static let shared = Router()
    
    func topMostController() -> UIViewController? {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        
        if var topController = keyWindow?.rootViewController {
            if let vc = topController as? UINavigationController {
                topController = vc.visibleViewController!
            }
            else {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
            }
//            
//            if let drawer = topController as? DrawerController {
//                if let tabBarController = drawer.rootViewController as? HomeTabBarController {
//                    if let vc = tabBarController.selectedViewController as? CustomNavigationController {
//                        topController = vc
//                    }
//                }
//            }

            if let navigationController = topController as? UINavigationController {
                if let vc = navigationController.topViewController {
                    topController = vc
                }
            }
            
            return topController
        }
        
        return nil
    }
    
    func showBankDialog(inViewController viewController: UIViewController, isFromEdit: Bool, bankObj: Bank?){
        if let controller = Storyboards.POPUP.instantiateViewController(withIdentifier: AlertAddEditBankViewController.className) as? AlertAddEditBankViewController {
            controller.bankObj = bankObj
            controller.isFromEdit = isFromEdit
            controller.delegate = viewController.self as? PopUpDismissDelegate
            let navController = UINavigationController(rootViewController: controller)

            viewController.presentAsFormSheet(controller: navController, width: UIScreen.main.bounds.width*1, height: UIScreen.main.bounds.height*0.85)
        }
    }
    
    func showSelectionDialog(inViewController viewController: UIViewController, selectionList: [String], title: String){
        if let controller = Storyboards.POPUP.instantiateViewController(withIdentifier: AlertSelectionViewController.className) as? AlertSelectionViewController {
            controller.dialogTitle = title
            controller.itemsList = selectionList
            controller.delegate = viewController as? ItemSelected
            let navController = UINavigationController(rootViewController: controller)
            navController.navigationBar.isHidden = true
            viewController.presentAsFormSheet(controller: navController, width: UIScreen.main.bounds.width*0.85, height: UIScreen.main.bounds.height*0.85)
        }
    }
    
    func gotoEditIncomeController(inViewController viewController: UIViewController, incomeObj : Income?) {
        if let controller = Storyboards.PROFILE.instantiateViewController(withIdentifier: EditIncomeProfileViewController.className) as? EditIncomeProfileViewController {
            controller.incomeObj = incomeObj
            viewController.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func showScanningBankConfirmationDialog(inViewController viewController: UIViewController){
        if let controller = Storyboards.CrowdSavingsAlerts.instantiateViewController(withIdentifier: AlertScanningAuthorizationController.className) as? AlertScanningAuthorizationController {
            let navController = UINavigationController(rootViewController: controller)
            viewController.presentAsFormSheet(controller: navController, width: UIScreen.main.bounds.width*1, height: UIScreen.main.bounds.height*0.85)
        }
    }
    
    func showScanningWaitingDialog(inViewController viewController: UIViewController){
        if let controller = Storyboards.CrowdSavingsAlerts.instantiateViewController(withIdentifier: AlertScanningLoaderController.className) as? AlertScanningLoaderController {
            let navController = UINavigationController(rootViewController: controller)
            viewController.presentAsFormSheet(controller: navController, width: UIScreen.main.bounds.width*1, height: UIScreen.main.bounds.height*0.85)
        }
    }

    
    func showCrowdSavingAvailableOptionsDialog(inViewController viewController: UIViewController){
        if let controller = Storyboards.CrowdSavingsAlerts.instantiateViewController(withIdentifier: AlertCrowdSavingOptionsController.className) as? AlertCrowdSavingOptionsController {
            let navController = UINavigationController(rootViewController: controller)
            viewController.presentAsFormSheet(controller: navController, width: UIScreen.main.bounds.width*1, height: UIScreen.main.bounds.height*0.85)
        }
    }

    func gotoProgramConfirmationController(inViewController viewController: UIViewController) {
        if let controller = Storyboards.MAIN.instantiateViewController(withIdentifier: ProgramConfirmationViewController.className) as? ProgramConfirmationViewController {
            viewController.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func gotoProgramDetailnController(inViewController viewController: UIViewController) {
        if let controller = Storyboards.MAIN.instantiateViewController(withIdentifier: CrowdSavingDetailViewController.className) as? CrowdSavingDetailViewController {
            viewController.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func gotoProfileScreen(inViewController controller: UIViewController){
        if let viewController = Storyboards.PROFILE.instantiateViewController(withIdentifier: ProfileViewController.className) as? ProfileViewController {
            controller.navigationController!.pushViewController(viewController, animated: true)
        }
    }
    
    func gotoSavingHubScreen(inViewController controller: UIViewController){
        if let viewController = Storyboards.SAVING_HUB.instantiateViewController(withIdentifier: SavingHubViewController.className) as? SavingHubViewController {
            controller.navigationController!.pushViewController(viewController, animated: true)
        }
    }
    
    func gotoEditProfileScreen(inViewController controller: UIViewController, obj: ProfileDataClass?) {
        if let viewController = Storyboards.PROFILE.instantiateViewController(withIdentifier: EditPersonalProfileViewController.className) as? EditPersonalProfileViewController {
            viewController.obj = obj
            controller.navigationController!.pushViewController(viewController, animated: true)
        }
        
    }
    
    func gotoSTUSHCardScreen(inViewController controller:UIViewController) {
        if let viewController = Storyboards.OTHER.instantiateViewController(withIdentifier: StushDebitCardViewController.className) as? StushDebitCardViewController {
            controller.navigationController!.pushViewController(viewController, animated: true)
        }
    }
}

extension Router: UIPopoverPresentationControllerDelegate {
    
}
