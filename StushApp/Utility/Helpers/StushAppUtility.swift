//
//  StushAppUtility.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 8/22/23.
//


import UIKit

enum RowType: Int {
    case firstRow
    case lastRow
    case midRow
}

class ConsumerAppUtility: NSObject {
    
    static func addSwipeAnimationToLayer(leftSide: Bool) -> CATransition{
        let transition = CATransition.init()
        transition.startProgress = 0
        transition.endProgress = 1.0
        transition.type = .push
        transition.subtype = leftSide ? .fromRight : .fromLeft
        transition.duration = 0.3
        return transition
    }
    
    static func addFadeAnimationToLayer() -> CATransition{
        let transition = CATransition.init()
        transition.startProgress = 0
        transition.endProgress = 1.0
        transition.type = .fade
        transition.duration = 0.3
        return transition
    }
    
//    static func enableSideMenuGesture(isEnabled: Bool) {
//        if let window = AppDelegate.appDelegate().window, let drawerMenu = window.rootViewController as? DrawerController {
//            if(Bundle.getLanguage() == "ar"){
//                drawerMenu.isRightViewSwipeGestureEnabled = isEnabled
//            }
//            else {
//                drawerMenu.isLeftViewSwipeGestureEnabled = isEnabled
//            }
//        }
//    }
//
//    static func verifySessionTimeOut(_ error: HTTPError?) -> Bool {
//        if let error = error {
//            if error.localizedDescription == Constants.kSessionExpiredMessage {
//                AlertPopupService.sharedInstance.showSessionTimeoutAlert()
//                return true
//            }
//        }
//        return false
//    }
    
    static func addShadowAlongMultipleRows(toView view: UIView, rowType: RowType, shadowRadius: CGFloat = 4, cornerRadius: CGFloat = 17) {
        
        let backgroundView = view
        backgroundView.backgroundColor = UIColor.white
        
        if rowType == .firstRow {
            backgroundView.layer.cornerRadius = cornerRadius
            backgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        else if rowType == .lastRow {
            backgroundView.layer.cornerRadius = cornerRadius
            backgroundView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            backgroundView.layer.cornerRadius = 0
        }
        
        let backBounds = backgroundView.bounds
        // the shadow rect determines the area in which the shadow gets drawn
        var shadowRect: CGRect = backBounds.insetBy(dx: 0, dy: -10)
        if rowType == .firstRow {
            shadowRect.origin.y += 10
            
        } else if rowType == .lastRow {
            shadowRect.size.height -= 10
            
        }
        
        // the mask rect ensures that the shadow doesn't bleed into other table cells
        var maskRect: CGRect = backBounds.insetBy(dx: -10, dy: 0)
        if rowType == .firstRow {
            maskRect.origin.y -= 10
            maskRect.size.height += 10
        } else if rowType == .lastRow {
            maskRect.size.height += 10
        }
        
        // now configure the background view layer with the shadow
        let layer: CALayer = backgroundView.layer
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = 0.2
        layer.shadowPath = UIBezierPath(roundedRect: shadowRect, cornerRadius: cornerRadius).cgPath
        layer.masksToBounds = false
        
        // and finally add the shadow mask
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(rect: maskRect).cgPath
        layer.mask = maskLayer
    }
    
    static func addShadowAlongSingleRow(toView view: UIView, shadowRadius: CGFloat = 4, cornerRadius: CGFloat = 17) {
        
        let backgroundView = view
        backgroundView.backgroundColor = UIColor.white
    
        backgroundView.layer.cornerRadius = cornerRadius
        
        let backBounds = backgroundView.bounds
        // the shadow rect determines the area in which the shadow gets drawn
        let shadowRect: CGRect = backBounds.insetBy(dx: 0, dy: 0)
        
        // now configure the background view layer with the shadow
        let layer: CALayer = backgroundView.layer
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = 0.2
        layer.shadowPath = UIBezierPath(roundedRect: shadowRect, cornerRadius: cornerRadius).cgPath
        layer.masksToBounds = false
    }
    
    static func formattedDateFromString(dateString: String, withFormat format: String) -> String? {

        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = format

        if let date = inputFormatter.date(from: dateString) {

            let outputFormatter = DateFormatter()
          outputFormatter.dateFormat = "dd/MM/yyyy"

            return outputFormatter.string(from: date)
        }

        return nil
    }
    
    static func stringToDate(dateStr: String) -> Date? {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "dd/MM/yyyy"
        if let date = formatter.date(from: dateStr) {
            return date
        }
        return nil
    }
}

