
    //
    //  SecurePasswordTextFieldManager.swift
    //  weavr-ux-components
    //
    //  Created by Tareq Islam on 17/8/22.
    //

import Foundation
import WeavrComponents

@objc(SecureCardPinLabelManager)
class SecureCardPinLabelManager: RCTViewManager {
    
    override func view() -> (SecureCardPinLabelView) {
        return SecureCardPinLabelView()
    }
    
    @objc override static func requiresMainQueueSetup() -> Bool {
        return true
    }
    
    @objc(deTokenize:toDetokenize:)
    func deTokenize( _ reactTag: NSNumber, toDetokenize: String) {
        self.bridge!.uiManager.addUIBlock { (_: RCTUIManager?, viewRegistry: [NSNumber: UIView]?) in
            let view: SecureCardPinLabelView = (viewRegistry![reactTag] as? SecureCardPinLabelView)!
            view.createTokenNative(toDetokenize: toDetokenize)
        }
        
        
    }
}

