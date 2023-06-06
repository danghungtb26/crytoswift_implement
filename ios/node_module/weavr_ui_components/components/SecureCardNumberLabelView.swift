    //
    //  SecurePasswordTextField.swift
    //  weavr-ux-components
    //
    //  Created by Tareq Islam on 22/8/22.
    //

import Foundation
import UIKit
import WeavrComponents

class SecureCardNumberLabelView : UIView {

    @objc var onCreateTokenAction: RCTDirectEventBlock?
    @objc var onCopyToClipboardAction: RCTDirectEventBlock?

    @objc var backgroundViewColor: String = "" {
        didSet {
            self.backgroundColor = hexStringToUIColor(hexColor: backgroundViewColor)
        }
    }

    @objc var textColor: String = "" {
        didSet {
            self.secureCardPinLabel.textColor = hexStringToUIColor(hexColor: textColor)
        }
    }
    @objc var textSize: String = "" {
        didSet {

            self.secureCardPinLabel.font = self.secureCardPinLabel.font?.withSize(CGFloat((textSize as NSString).floatValue))

        }
    }

    @objc var fontStyle: NSDictionary = NSDictionary() {
	  didSet {

		if let fontFamily = fontStyle["fontFamily"] as? String {
		    let fontSize = (fontStyle["fontSize"] as? Int)  ?? 16
		    self.secureCardPinLabel.font = UIFont(name: fontFamily, size: CGFloat(fontSize)) ?? UIFont.systemFont(ofSize: CGFloat(fontSize))
		}
	  }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {

        secureCardPinLabel.frame = self.bounds
        self.addSubview(secureCardPinLabel)
    }


    lazy var secureCardPinLabel: SecureCardNumberLabel = {
        let secureCardPinLabel = SecureCardNumberLabel()

        secureCardPinLabel.font = UIFont.boldSystemFont(ofSize: 12)
        secureCardPinLabel.textAlignment = .left

        secureCardPinLabel.textColor = .green



            //        textFiled.textColor = .gray
            //        textFiled.layer.borderColor = UIColor.lightGray.cgColor
            //        textFiled.layer.borderWidth = 1
        return secureCardPinLabel
    }()

    @objc var copyOnClick: Bool = false {
        didSet {
            self.secureCardPinLabel.enableCopyTextToClipboardOnClick(enabled:copyOnClick, completion: {
                res in
//                print(res)
                self.onCopyToClipboardAction?(["value": res])
            }
            )
        }
    }

    @objc var copyOnLongClick: Bool = false {
        didSet {
            self.secureCardPinLabel.enableCopyTextToClipboardOnLongClick(enabled:copyOnLongClick, completion: {
                res in
//                print(res)
                self.onCopyToClipboardAction?(["value": res])
            }
            )
        }
    }


    func createTokenNative(toDetokenize : String){

        self.secureCardPinLabel.setTokeniseText(toDetokenise: toDetokenize,callback: {res in
            switch(res){

                case .success(let data):
//                    print(data)
                        //  resolve(data.first?.value)
                    self.onCreateTokenAction?(["value": data])
                case .failure(let err):
//                    print(err)
                    self.onCreateTokenAction?(["res": err])
                        //  resolve(err)
            }
        })
    }




    func hexStringToUIColor(hexColor: String) -> UIColor {
        let stringScanner = Scanner(string: hexColor)

        if(hexColor.hasPrefix("#")) {
            stringScanner.scanLocation = 1
        }
        var color: UInt32 = 0
        stringScanner.scanHexInt32(&color)

        let r = CGFloat(Int(color >> 16) & 0x000000FF)
        let g = CGFloat(Int(color >> 8) & 0x000000FF)
        let b = CGFloat(Int(color) & 0x000000FF)

        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
    }
}

