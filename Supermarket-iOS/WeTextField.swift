/**
* Copyright (c) 2000-present Liferay, Inc. All rights reserved.
*
* This library is free software; you can redistribute it and/or modify it under
* the terms of the GNU Lesser General Public License as published by the Free
* Software Foundation; either version 2.1 of the License, or (at your option)
* any later version.
*
* This library is distributed in the hope that it will be useful, but WITHOUT
* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
* FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
* details.
*/


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

		let fontSize: CGFloat = UIScreen.main.bounds.width > 340 ? 16 : 14

		font = UIFont.semiboldWeFont(ofSize: fontSize)

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

		return CGRect(x: self.frame.maxX - bounds.height-10, y: 10, width: bounds.height-20, height: bounds.height-20)
	}
    
    open func setErrorAppearance() {
        backgroundColor = UIColor(255, 64,64, 0.10);
        textColor = UIColor(255, 64, 64, 1)
    }

	func isPasswordFieldChanged() {
		if isPasswordField {
			showPasswordButton.backgroundColor = .WeTextFieldSelectedBackgroundColor
			showPasswordButton.titleLabel?.font = UIFont.iconFont12px(ofSize: 12)
			showPasswordButton.setTitle(.showPassword, for: .normal)
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

		showPasswordButton.setTitle(isSecureTextEntry ? .showPassword : .hidePassword, for: .normal)
	}

}
