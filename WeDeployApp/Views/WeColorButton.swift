//
//  WeButton.swift
//  WeDeployApp
//
//  Created by Victor Galán on 10/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import UIKit

class WeColorButton: UIButton {

	@IBInspectable open var darkButton: Bool = false
	@IBInspectable open var textSize: Int = 16

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

		layer.cornerRadius = 4
		setTitleColor(.white, for: .disabled)
		alpha = isEnabled ? 1 : 0.6

		titleLabel?.font = UIFont(name: "GalanoGrotesque-Bold", size: CGFloat(textSize))

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
