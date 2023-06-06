    //
    //  SecureCardPinTextFieldManager.swift
    //  weavr-ux-components
    //
    //  Created by Tareq Islam on 17/8/22.
    //

import Foundation
import WeavrComponents

@objc(SecureCardPinTextFieldManager)
class SecureCardPinTextFieldManager: RCTViewManager {
    
    override func view() -> (SecureCardPinTextField) {
        return SecureCardPinTextField()
    }
    
    @objc override static func requiresMainQueueSetup() -> Bool {
        return true
    }
    
    @objc func createToken( _ reactTag: NSNumber) {
        self.bridge!.uiManager.addUIBlock { (_: RCTUIManager?, viewRegistry: [NSNumber: UIView]?) in
            let view: SecureCardPinTextField = (viewRegistry![reactTag] as? SecureCardPinTextField)!
            view.createTokenNative()
        }
        
        
    }
    @objc func getTag(_ reactTag: NSNumber) {
        self.bridge!.uiManager.addUIBlock{(_:RCTUIManager?,
                                           viewRegistry: [NSNumber: UIView]?) in
            let view: SecureCardPinTextField = (viewRegistry![reactTag] as? SecureCardPinTextField)!
            view.getTagNative()
            
        }
    }
}

