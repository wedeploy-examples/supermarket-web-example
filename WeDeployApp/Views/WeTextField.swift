//
//  BorderLessTextField.swift
//  WeDeployApp
//
//  Created by Victor Galán on 10/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import UIKit

class BorderLessTextField: UITextField {

	@IBInspectable var isPasswordField: Bool = false {
		didSet {
			isPasswordFieldChanged()
		}
	}

	var showPasswordButton = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))

	override init(frame: CGRect) {
		super.init(frame: frame)
		initialize()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		initialize()
	}

	func initialize() {
		layer.borderColor = UIColor.clear.cgColor
		layer.borderWidth = 0
		layer.cornerRadius = 4

		textColor = .WeTextFieldTextColor

		font = UIFont(name: "GalanoGrotesque-SemiBold", size: 16)

		tintColor = .mainColor
	}

	override func becomeFirstResponder() -> Bool {
		backgroundColor = .WeTextFieldSelectedBackgroundColor
        textColor = .WeTextFieldTextColor
		return super.becomeFirstResponder()
	}

	override func resignFirstResponder() -> Bool {
		self.backgroundColor = .WeTextFieldBackgroundColor
		return super.resignFirstResponder()
	}

	override func editingRect(forBounds bounds: CGRect) -> CGRect {
		var rect = super.editingRect(forBounds: bounds)
		let defaultPadding = rect.origin.x

		rect.origin.x = 20
		rect.size.width = rect.size.width - (60 - defaultPadding)

		return rect
	}

	override func textRect(forBounds bounds: CGRect) -> CGRect {
		var rect = super.textRect(forBounds: bounds)
		let defaultPadding = rect.origin.x

		rect.origin.x = 20
		rect.size.width = rect.size.width - (60 - defaultPadding)

		return rect
	}

	override func rightViewRect(forBounds bounds: CGRect) -> CGRect {

		return CGRect(x: self.frame.maxX - 70, y: 10, width: 40, height: 40)
	}
    
    open func setErrorAppearance() {
        backgroundColor = UIColor(255, 64,64, 0.10);
        textColor = UIColor(255, 64, 64, 1)
    }

	func isPasswordFieldChanged() {
		if isPasswordField {
			showPasswordButton.backgroundColor = .WeTextFieldSelectedBackgroundColor
			showPasswordButton.titleLabel?.font = UIFont(name: "loop-icons-12px", size: 12)
			showPasswordButton.setTitle("\u{E04B}", for: .normal)
			showPasswordButton.addTarget(self, action: #selector(showOrHidePassword), for: .touchUpInside)
			showPasswordButton.setTitleColor(.WeTextColor, for: .normal)
			showPasswordButton.layer.cornerRadius = 4
			rightView = showPasswordButton
			rightViewMode = .always
			isSecureTextEntry = true
		}
		else {
			showPasswordButton.removeTarget(self, action: #selector(showOrHidePassword), for: .touchUpInside)
			rightViewMode = .never
			isSecureTextEntry = false
		}
	}

	func showOrHidePassword() {
		isSecureTextEntry = !isSecureTextEntry

		showPasswordButton.setTitle(isSecureTextEntry ? "\u{E04B}" : "\u{E037}", for: .normal)
	}

}
