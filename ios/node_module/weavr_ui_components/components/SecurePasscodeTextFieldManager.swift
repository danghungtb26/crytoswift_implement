    //
    //  SecurePasscodeTextFieldManager.swift
    //  weavr-ux-components
    //
    //  Created by Tareq Islam on 17/8/22.
    //

import Foundation
import WeavrComponents

@objc(SecurePasscodeTextFieldManager)
class SecurePasscodeTextFieldManager: RCTViewManager {
    
    override func view() -> (SecurePasscodeTextField) {
        return SecurePasscodeTextField()
    }
    
    @objc override static func requiresMainQueueSetup() -> Bool {
        return true
    }
    
    @objc func createToken( _ reactTag: NSNumber) {
        self.bridge!.uiManager.addUIBlock { (_: RCTUIManager?, viewRegistry: [NSNumber: UIView]?) in
            let view: SecurePasscodeTextField = (viewRegistry![reactTag] as? SecurePasscodeTextField)!
            view.createTokenNative()
        }
        
        
    }
    @objc func getTag(_ reactTag: NSNumber) {
        self.bridge!.uiManager.addUIBlock{(_:RCTUIManager?,
                                           viewRegistry: [NSNumber: UIView]?) in
            let view: SecurePasscodeTextField = (viewRegistry![reactTag] as? SecurePasscodeTextField)!
            view.getTagNative()
            
        }
    }
}

