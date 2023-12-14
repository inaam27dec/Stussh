//
//  UIViewController+Extension.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 8/22/23.
//


import Foundation
import UIKit
import ARSLineProgress
import MZFormSheetPresentationController

extension UIViewController{
    
    func showLoader() {
        self.view.isUserInteractionEnabled = false
        ARSLineProgressConfiguration.backgroundViewStyle = .full
        ARSLineProgressConfiguration.backgroundViewColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        ARSLineProgressConfiguration.blurStyle = .extraLight
        ARSLineProgressConfiguration.circleColorOuter = Colors.APP_PRIMARY_COLOR!.cgColor
        ARSLineProgressConfiguration.circleColorMiddle = Colors.APP_SECONDARY_COLOR!.cgColor
        ARSLineProgressConfiguration.circleColorInner = Colors.APP_PRIMARY_COLOR!.cgColor
        ARSLineProgress.show()
        
    }
    
    func hideLoader(){
        self.view.isUserInteractionEnabled = true
        ARSLineProgress.hide()
    }
    
    func addLogoToNavigationBarItem() {
//        self.navigationItem.titleView = Icons.LOGO
    }
    
    func addCrossButton() {
        let btn : UIButton = UIButton()
//        btn.setImage(Icons.CROSS, for: .normal)
        btn.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
    }
    
    func addNavBarRightButton(title: String, image: UIImage, isleftButton: Bool, buttonAction: Selector) {
        
        self.navigationItem.setHidesBackButton(true, animated:false)
        let btn : UIButton = UIButton(frame: CGRect(x:0, y:0, width:39, height:44))
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitle(title, for: .normal)
        btn.setImage(image, for: .normal)
        btn.contentMode = .scaleAspectFill
        btn.addTarget(self, action: buttonAction, for: .touchDown)
        let rightBarButon: UIBarButtonItem = UIBarButtonItem(customView: btn)
        if (isleftButton) {
            self.navigationItem.setLeftBarButtonItems([rightBarButon], animated: false)

        } else {
        self.navigationItem.setRightBarButtonItems([rightBarButon], animated: false)
        }
    }
    
    func addBackButton() {
        let btn : UIButton = UIButton()
//        btn.setImage(Icons.ARROW_BACK, for: .normal)
        btn.addTarget(self, action: #selector(popController), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = nil
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        self.navigationItem.hidesBackButton = true
    }
    
    func updateNavBarTitle(withText title: String, font: UIFont, color: UIColor = Colors.CUSTOM_GRAY!) {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.CUSTOM_GRAY!, NSAttributedString.Key.font: font]
        navigationItem.title = title
    }
    
    func showToast(message: String, duration: TimeInterval = 1.5) {
//        if let toastView = Bundle.main.loadNibNamed(ToastMessageView.className, owner: self, options: nil)?.first as? ToastMessageView {
//            toastView.labelMessage.text = message
//            toastView.viewContainer.alpha = 0.0
//            toastView.frame = CGRect(x: 0, y: 100, width: self.view.frame.width, height: toastView.frame.size.height)
//            self.view.addSubview(toastView)
//
//            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn) {
//                toastView.viewContainer.alpha = 1.0
//            } completion: { _ in
//                UIView.animate(withDuration: 0.5, delay: duration, options: .curveEaseOut) {
//                    toastView.viewContainer.alpha = 0.0
//                } completion: { _ in
//                    toastView.removeFromSuperview()
//                }
//            }
//
//        }
    }
    
    @objc func dismissController() {
        self.dismiss(animated: true)
    }
    
    @objc func popController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func presentAsFormSheet(controller: UIViewController, width: CGFloat, height: CGFloat, cornerRadius: CGFloat = 18, shouldDismissOnBgTap: Bool = true) {
        let formSheetController = MZFormSheetPresentationViewController(contentViewController: controller)
        formSheetController.presentationController?.contentViewSize = CGSize(width: width, height: height)
        formSheetController.presentationController?.shouldCenterHorizontally = true
        formSheetController.presentationController?.shouldCenterVertically = true
        formSheetController.presentationController?.shouldDismissOnBackgroundViewTap = shouldDismissOnBgTap
        formSheetController.contentViewCornerRadius = cornerRadius
        formSheetController.contentViewControllerTransitionStyle = .slideFromBottom
        present(formSheetController, animated: true, completion: nil)
    }
}

