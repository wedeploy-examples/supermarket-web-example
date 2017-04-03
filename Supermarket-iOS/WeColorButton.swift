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

class WeColorButton: UIButton {

	@IBInspectable open var darkButton: Bool = false
	@IBInspectable open var textSize: Int = 16
	@IBInspectable open var cornerRadius: Int = 4

	override var isEnabled: Bool {
		didSet {
			alpha = isEnabled ? 1 : 0.6
		}
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		initialize()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	override func awakeFromNib() {
		super.awakeFromNib()

		initialize()
	}

	func initialize() {

		layer.cornerRadius = CGFloat(cornerRadius)
		setTitleColor(.white, for: .disabled)
		alpha = isEnabled ? 1 : 0.6

		titleLabel?.font = UIFont.boldWeFont(ofSize: CGFloat(textSize))

		if darkButton {
			setTitleColor(.white, for: .normal)
			backgroundColor = .mainColor
		}
		else {
			setTitleColor(.mainColor, for: .normal)
			backgroundColor = .white
		}
	}

}
