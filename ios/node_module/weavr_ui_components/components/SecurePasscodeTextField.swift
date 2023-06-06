    //
    //  SecurePasswordTextField.swift
    //  weavr-ux-components
    //
    //  Created by Tareq Islam on 22/8/22.
    //

import Foundation
import UIKit
import WeavrComponents

class SecurePasscodeTextField : UIView, SecureTextProtocol {



    @objc var onCreateTokenAction: RCTDirectEventBlock?
    @objc var onGetTagAction : RCTDirectEventBlock?
    @objc var onTextChangesAction : RCTDirectEventBlock?
    @objc var onFocusAction : RCTDirectEventBlock?
    var viewTag : String?

    @objc var backgroundViewColor: String = "" {
	  didSet {
		self.backgroundColor = hexStringToUIColor(hexColor: backgroundViewColor)

	  }
    }

    @objc var textSize: String = "" {
        didSet {

            self.securePasswordField.font = self.securePasswordField.font?.withSize(CGFloat((textSize as NSString).floatValue))

        }
    }

    @objc var placeholder: String = "" {
        didSet {
            self.securePasswordField.placeholder = placeholder
        }
    }

    @objc var placeholderTextColor: String = "" {
        didSet {
            self.securePasswordField.attributedPlaceholder = NSAttributedString(
		    string: self.securePasswordField.placeholder != nil ? self.securePasswordField.placeholder! : "Passcode",
                attributes: [NSAttributedString.Key.foregroundColor: hexStringToUIColor(hexColor: placeholderTextColor)]
            )
        }
    }

    @objc var background: Bool = true {
        didSet {
            if(background) {self.securePasswordField.borderStyle = .roundedRect}
        }
    }
    @objc var fontStyle: NSDictionary = NSDictionary() {
	  didSet {

		if let fontFamily = fontStyle["fontFamily"] as? String {
		    let fontSize = (fontStyle["fontSize"] as? Int)  ?? 16
		    self.securePasswordField.font = UIFont(name: fontFamily, size: CGFloat(fontSize)) ?? UIFont.systemFont(ofSize: CGFloat(fontSize))
		}
		if let fontColor = fontStyle["color"] as? String {
		    self.securePasswordField.textColor = hexStringToUIColor(hexColor: fontColor)
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
            //        let textField = securePasswordField
            //        textField.placeholder = self.placeholder
        securePasswordField.frame = self.bounds
        self.addSubview(securePasswordField)


        self.viewTag = "\(self.reactTag!)"
        allEditTexts["\(viewTag!)"] = self
        getTagNative()
    }


    lazy var securePasswordField: SecureTextField = {
        let textFiled = SecurePasscodeField()





        textFiled.font = UIFont.boldSystemFont(ofSize: 12)
        textFiled.textAlignment = .left

        textFiled.addDoneButtonOnKeyboard()


        textFiled.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
        textFiled.addTarget(self, action: #selector(textViewDidBeginEditing(_:)), for: .editingDidBegin)

            //        textFiled.textColor = .gray
            //        textFiled.layer.borderColor = UIColor.lightGray.cgColor
            //        textFiled.layer.borderWidth = 1

        return textFiled
    }()


    @objc private func textFieldDidChanged(_ textField: UITextView) {
        self.onTextChangesAction?(["event": "text changed"])
    }

    @objc private func textViewDidBeginEditing(_ textField: UITextView) {
        self.onTextChangesAction?(["event": "on Focus"])
    }

    func getTagNative(){
        self.onGetTagAction?(["value": "\(self.reactTag!)"])
    }


    func createTokenNative(){
        self.securePasswordField.createToken(callBack: {res in
            switch(res){

                case .success(let data):
                    // print(data)
                        //  resolve(data.first?.value)
                    self.onCreateTokenAction?(["value": data.first?.value as Any])
                case .failure(let res):
                    // print(err)
                    self.onCreateTokenAction?(["value": res.message])
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

