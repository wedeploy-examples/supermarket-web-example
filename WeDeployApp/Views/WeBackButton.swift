//
//  WeBackButton.swift
//  WeDeployApp
//
//  Created by Victor Galán on 12/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import UIKit

class WeBackButton: UIButton {

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
		titleLabel?.font = UIFont.iconFont12px(ofSize: 24)
		setTitle(.back, for: .normal)
		setTitleColor(.WePlaceholderTextColor, for: .normal)
	}

}
