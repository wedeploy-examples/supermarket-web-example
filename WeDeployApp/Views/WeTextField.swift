//
//  BorderLessTextField.swift
//  WeDeployApp
//
//  Created by Victor Galán on 10/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import UIKit

class BorderLessTextField: UITextField {

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

		UIFont.familyNames.forEach{print(UIFont.fontNames(forFamilyName: $0))}

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
    
    open func setErrorAppearance() {
        backgroundColor = UIColor(255, 64,64, 0.10);
        textColor = UIColor(255, 64, 64, 1)
    }

}
