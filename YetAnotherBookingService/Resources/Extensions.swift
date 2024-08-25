//
//  Extensions.swift
//  YetAnotherBookingService
//
//  Created by Admin on 06.06.2024.
//

import Foundation
import UIKit

extension UIView {
    func getParentViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.getParentViewController()
        } else {
            return nil
        }
    }
}
