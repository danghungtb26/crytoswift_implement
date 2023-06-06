    //
    //  SecurePasswordTextFieldManager.swift
    //  weavr-ux-components
    //
    //  Created by Tareq Islam on 17/8/22.
    //

import Foundation
import WeavrComponents

@objc(SecurePasswordTextFieldManager)
class SecurePasswordTextFieldManager: RCTViewManager {
    
    override func view() -> (SecurePasswordTextField) {
        return SecurePasswordTextField()
    }
    
    @objc override static func requiresMainQueueSetup() -> Bool {
        return true
    }
    
    @objc func createToken( _ reactTag: NSNumber) {
        self.bridge!.uiManager.addUIBlock { (_: RCTUIManager?, viewRegistry: [NSNumber: UIView]?) in
            let view: SecurePasswordTextField = (viewRegistry![reactTag] as? SecurePasswordTextField)!
            view.createTokenNative()
        }
        
        
    }
    @objc func getTag(_ reactTag: NSNumber) {
        self.bridge!.uiManager.addUIBlock{(_:RCTUIManager?,
                                           viewRegistry: [NSNumber: UIView]?) in
            let view: SecurePasswordTextField = (viewRegistry![reactTag] as? SecurePasswordTextField)!
            view.getTagNative()
            
        }
    }
}

