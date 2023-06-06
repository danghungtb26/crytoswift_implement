
    //
    //  SecurePasswordTextFieldManager.swift
    //  weavr-ux-components
    //
    //  Created by Tareq Islam on 17/8/22.
    //

import Foundation
import WeavrComponents

@objc(SecureCardCVVLabelManager)
class SecureCardCVVLabelManager: RCTViewManager {
    
    override func view() -> (SecureCardCVVLabelView) {
        return SecureCardCVVLabelView()
    }
    
    @objc override static func requiresMainQueueSetup() -> Bool {
        return true
    }
    
    @objc(deTokenize:toDetokenize:)
    func deTokenize( _ reactTag: NSNumber, toDetokenize: String) {
        self.bridge!.uiManager.addUIBlock { (_: RCTUIManager?, viewRegistry: [NSNumber: UIView]?) in
            let view: SecureCardCVVLabelView = (viewRegistry![reactTag] as? SecureCardCVVLabelView)!
            view.createTokenNative(toDetokenize: toDetokenize)
        }
        
        
    }
}

