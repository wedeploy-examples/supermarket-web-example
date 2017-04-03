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

public class ViewWithArrow : UIView {

	public var text: String? {
		didSet {
			labelText.text = text
		}
	}

	public var onClick: (() -> Void)?

	override public init(frame: CGRect) {
		super.init(frame: frame)
		initialize()
	}

	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		initialize()
	}

	let labelText = UILabel()
	let arrow = UILabel()

	func initialize() {
		layer.cornerRadius = 4
		backgroundColor = .WeTextFieldSelectedBackgroundColor

		self.translatesAutoresizingMaskIntoConstraints = false

		labelText.text = "All"
		labelText.textColor = .WeTextColor
		labelText.translatesAutoresizingMaskIntoConstraints = false
		labelText.font = UIFont.boldSystemFont(ofSize: 14)

		arrow.text = .arrow
		arrow.textColor = .WeTextColor
		arrow.translatesAutoresizingMaskIntoConstraints = false
		arrow.font = UIFont.iconFont12px(ofSize: 12)

		addSubview(labelText)
		addSubview(arrow)

		labelText.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
		labelText.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

		arrow.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
		arrow.leadingAnchor.constraint(equalTo: labelText.trailingAnchor, constant: 7).isActive = true
		arrow.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
	}

	public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		onClick?()
	}
}
