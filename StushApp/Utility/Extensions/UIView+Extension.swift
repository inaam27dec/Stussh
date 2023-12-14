//
//  UIView+Extension.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 8/22/23.
//

import Foundation
import UIKit
import ARSLineProgress

public extension UIView {
    
    /// Border color of view; also inspectable from Storyboard.
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        
        set {
            guard let color = newValue else {
                layer.borderColor = nil
                return
            }
            
            layer.borderColor = color.cgColor
        }
    }
    
    /// Border width of view; also inspectable from Storyboard.
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    /// Corner radius of view; also inspectable from Storyboard.
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        
        set {
//            layer.masksToBounds = true
            layer.cornerRadius = newValue
        }
    }
    
    func addShadow(cornerRadius: CGFloat) {
        layer.masksToBounds = false
        layer.cornerRadius = cornerRadius
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 2
    }
    func showLoader() {
        self.isUserInteractionEnabled = false
        ARSLineProgressConfiguration.backgroundViewStyle = .full
        ARSLineProgressConfiguration.blurStyle = .extraLight
        ARSLineProgressConfiguration.circleColorOuter = Colors.APP_BLUE!.cgColor
        ARSLineProgressConfiguration.circleColorMiddle = Colors.PINK_THEME_COLOR!.cgColor
        ARSLineProgressConfiguration.circleColorInner = Colors.APP_BLUE!.cgColor
        ARSLineProgress.show()
        
    }
    
    func hideLoader(){
        self.isUserInteractionEnabled = true
        ARSLineProgress.hide()
    }
    
    func setGradientBtnBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [Colors.PINK_THEME_COLOR!.cgColor, Colors.APP_BLUE!.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.frame = self.bounds
        self.clipsToBounds = true
        self.layer.insertSublayer(gradientLayer, at:1)
    }
    
    func lock() {
      if let _ = viewWithTag(10) {
        //View is already locked
      }
      else {
        let lockView = UIView(frame: bounds)
        lockView.backgroundColor = UIColor(white: 0.0, alpha: 0.75)
        lockView.tag = 10
        lockView.alpha = 0.0
        let activity = UIActivityIndicatorView(style: .medium)
        activity.color = .white
        activity.hidesWhenStopped = true
        activity.center = lockView.center
        lockView.addSubview(activity)
        activity.startAnimating()
        addSubview(lockView)
        
        UIView.animate(withDuration: 0.2) {
          lockView.alpha = 1.0
        }
      }
    }
    
    func unlock() {
      if let lockView = viewWithTag(10) {
        UIView.animate(withDuration: 0.2, animations: {
          lockView.alpha = 0.0
        }, completion: { finished in
          lockView.removeFromSuperview()
        })
      }
    }
    
    func fadeOut(_ duration: TimeInterval) {
      UIView.animate(withDuration: duration) {
        self.alpha = 0.0
      }
    }
    
    func fadeIn(_ duration: TimeInterval) {
      UIView.animate(withDuration: duration) {
        self.alpha = 1.0
      }
    }
    
    class func viewFromNibName(_ name: String) -> UIView? {
      let views = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
      return views?.first as? UIView
    }
    
    func fadeInView(duration: TimeInterval = 0.5,
                  delay: TimeInterval = 0.0,
                  completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }) {
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: UIView.AnimationOptions.curveEaseIn,
                       animations: {
          self.alpha = 1.0
        }, completion: completion)
      }

      func fadeOutView(duration: TimeInterval = 0.5,
                   delay: TimeInterval = 0.0,
                   completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in }) {
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: UIView.AnimationOptions.curveEaseIn,
                       animations: {
          self.alpha = 0.0
        }, completion: completion)
      }
    
    @discardableResult
    func addBorders(edges: UIRectEdge,
                    color: UIColor,
                    inset: CGFloat = 0.0,
                    thickness: CGFloat = 1.0) -> [UIView] {

        var borders = [UIView]()

        @discardableResult
        func addBorder(formats: String...) -> UIView {
            let border = UIView(frame: .zero)
            border.backgroundColor = color
            border.translatesAutoresizingMaskIntoConstraints = false
            addSubview(border)
            addConstraints(formats.flatMap {
                NSLayoutConstraint.constraints(withVisualFormat: $0,
                                               options: [],
                                               metrics: ["inset": inset, "thickness": thickness],
                                               views: ["border": border]) })
            borders.append(border)
            return border
        }


        if edges.contains(.top) || edges.contains(.all) {
            addBorder(formats: "V:|-0-[border(==thickness)]", "H:|-inset-[border]-inset-|")
        }

        if edges.contains(.bottom) || edges.contains(.all) {
            addBorder(formats: "V:[border(==thickness)]-0-|", "H:|-inset-[border]-inset-|")
        }

        if edges.contains(.left) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:|-0-[border(==thickness)]")
        }

        if edges.contains(.right) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:[border(==thickness)]-0-|")
        }

        return borders
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            let path = UIBezierPath(
                roundedRect: bounds,
                byRoundingCorners: corners,
                cornerRadii: CGSize(width: radius, height: radius)
            )
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }

}

