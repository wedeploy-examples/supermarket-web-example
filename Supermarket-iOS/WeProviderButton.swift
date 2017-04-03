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
import WeDeploy

@IBDesignable open class WeProviderButton : UIButton {

	@IBInspectable open var providerName: String? = "github"

	open var provider: AuthProvider.Provider?

	open override var isEnabled: Bool {
		didSet {
			enabledChanged()
		}
	}

	override public init(frame: CGRect) {
		super.init(frame: frame)

		initalize()
	}

	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)

	}

	open override func awakeFromNib() {
		super.awakeFromNib()

		initalize()
	}

	open func initalize() {
		guard let provider = AuthProvider.Provider(rawValue: providerName!) else {
			print("wrong provider name")
			return
		}
		self.provider = provider
		let providerSettings = provider.providerSettings

		backgroundColor = providerSettings.color

		setTitle(providerSettings.icon, for: .normal)
		setTitleColor(.white, for: .normal)
		let fontSize: CGFloat = UIScreen.main.bounds.width > 340 ? 24: 20
		titleLabel?.font = UIFont.iconFont12px(ofSize: fontSize)

		layer.cornerRadius = 4
	}

	func enabledChanged() {
		if !isEnabled {
			setTitle(.processing, for: .normal)
			backgroundColor = UIColor(59, 88, 152, 0.6)
		}
		else {
			initalize()
		}
	}

}

extension AuthProvider.Provider {

	var providerSettings: (color: UIColor, icon: String) {
		switch self {
		case .facebook:
			return (.FacebookColor, .facebook)
		case .github:
			return (.GithubColor, .github)
		case .google:
			return (.GoogleColor, .google)
		}
	}
}
