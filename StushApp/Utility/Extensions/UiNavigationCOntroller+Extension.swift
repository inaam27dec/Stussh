//
//  UiNavigationCOntroller+Extension.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 8/22/23.
//


import Foundation
import UIKit

extension UINavigationController {
  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
      popToViewController(vc, animated: animated)
    }
  }
}
