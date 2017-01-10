//
//  BorderLessTextField.swift
//  WeDeployApp
//
//  Created by Victor Galán on 10/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import UIKit

class BorderLessTextField: UITextField {

	@IBInspectable var selectedBackgroundColor: UIColor = .clear
	var unselectedBackgroundColor: UIColor?

	override init(frame: CGRect) {
		super.init(frame: frame)
		initialize()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		initialize()
	}

	func initialize() {
		unselectedBackgroundColor = backgroundColor
		layer.borderColor = UIColor.clear.cgColor
		layer.cornerRadius = 4

		tintColor = .yellow
	}

	override func becomeFirstResponder() -> Bool {
		self.backgroundColor = selectedBackgroundColor
		return super.becomeFirstResponder()
	}

	override func resignFirstResponder() -> Bool {
		self.backgroundColor = unselectedBackgroundColor
		return super.resignFirstResponder()
	}

	override func editingRect(forBounds bounds: CGRect) -> CGRect {
		var rect = super.editingRect(forBounds: bounds)
		let defaultPadding = rect.origin.x

		rect.origin.x = 20
		rect.size.width = rect.size.width - (60 - defaultPadding)

		return rect
	}

}
