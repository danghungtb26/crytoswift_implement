//
//  UIView+Util.swift
//  weavr-ux-components
//
//  Created by Tareq Islam on 29/8/22.
//

import Foundation
extension UIView {
    public class func findByAccessibilityIdentifier(identifier: String) -> UIView? {
        
        guard let window = UIWindow.key else {
            return nil
        }
        
        func findByID(view: UIView, _ id: String) -> UIView? {
            if view.accessibilityIdentifier == id { return view }
            for v in view.subviews {
                if let a = findByID(view: v, id) { return a }
            }
            return nil
        }
        
        return findByID(view: window, identifier)
    }
}

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
