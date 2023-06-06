
    //
    //  SecurePasswordTextFieldManager.swift
    //  weavr-ux-components
    //
    //  Created by Tareq Islam on 17/8/22.
    //

import Foundation
import WeavrComponents

@objc(SecureCardNumberLabelManager)
class SecureCardNumberLabelManager: RCTViewManager {
    
    override func view() -> (SecureCardNumberLabelView) {
        return SecureCardNumberLabelView()
    }
    
    @objc override static func requiresMainQueueSetup() -> Bool {
        return true
    }
    
    @objc(deTokenize:toDetokenize:)
    func deTokenize( _ reactTag: NSNumber, toDetokenize: String) {
        self.bridge!.uiManager.addUIBlock { (_: RCTUIManager?, viewRegistry: [NSNumber: UIView]?) in
            let view: SecureCardNumberLabelView = (viewRegistry![reactTag] as? SecureCardNumberLabelView)!
            view.createTokenNative(toDetokenize: toDetokenize)
        }
        
        
    }
}

