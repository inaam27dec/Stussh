//
//  UITextField+Extension.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 8/22/23.
//

import Foundation
import UIKit

private var __maxLengths = [UITextField: Int]()
extension UITextField{
    
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            if let color = self.attributedPlaceholder?.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor {
                return color
            }
            return nil
        }
        set (setOptionalColor) {
            if let setColor = setOptionalColor {
                let string = self.placeholder ?? ""
                self.attributedPlaceholder = NSAttributedString(string: string , attributes:[NSAttributedString.Key.foregroundColor: setColor])
            }
        }
    }
    
    @objc func fix(textField: UITextField) {
        let t = textField.text
        if let t: String = textField.text {
            textField.text = String(t.prefix(maxLength))
        }
    }
    
    func consumerAppTextField(cornerRadius: CGFloat){
        self.layer.borderColor = Colors.APP_FIELD_BORDER_COLOR?.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = cornerRadius
        self.paddingLeft(inset: 10)
    }
    
    func paddingLeft(inset: CGFloat){
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: inset, height: self.frame.height))
        self.leftViewMode = UITextField.ViewMode.always
    }
    
    
    fileprivate func setPasswordToggleImage(_ button: UIButton) {
        if(isSecureTextEntry){
            button.setImage(UIImage(named: "pass_hide"), for: .normal)
        }else{
            button.setImage(UIImage(named: "pass_show"), for: .normal)
        }
    }
    
    func enablePasswordToggle(button: UIButton){
        self.isSecureTextEntry = true
        setPasswordToggleImage(button)
        button.addTarget(self, action: #selector(self.togglePasswordView), for: .touchUpInside)
    }
    
    @IBAction func togglePasswordView(_ sender: Any) {
        self.isSecureTextEntry = !self.isSecureTextEntry
        setPasswordToggleImage(sender as! UIButton)
    }
}

