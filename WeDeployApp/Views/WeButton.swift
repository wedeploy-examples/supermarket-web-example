//
//  WeButton.swift
//  WeDeployApp
//
//  Created by Victor Galán on 10/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import UIKit

class WeButton: UIButton {

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
		initialize()
	}

	func initialize() {
		layer.cornerRadius = 4

		tintColor = .white

		alpha = isEnabled ? 1 : 0.6
		
		setTitleColor(.white, for: .disabled)
	}

}
