//
//  ViewWithArrow.swift
//  WeDeployApp
//
//  Created by Victor Galán on 18/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

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
