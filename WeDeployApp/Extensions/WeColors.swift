//
//  WeColors.swift
//  WeDeployApp
//
//  Created by Victor Galán on 11/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import UIKit

extension UIColor {

	@nonobjc public static var mainColor = UIColor(8, 223, 133, 1)

	convenience init(_ red: Int, _ green: Int, _ blue: Int, _ alpha: CGFloat) {

		self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: alpha)
	}

	open class var WeTextFieldBackgroundColor: UIColor {
		return UIColor(14, 19, 26, 0.05)
	}

	open class var WeTextFieldSelectedBackgroundColor: UIColor {
		return UIColor(14, 19, 26, 0.1)
	}

	open class var WeTextFieldTextColor: UIColor {
		return UIColor(14, 20, 26, 0.8)
	}

	open class var WeTextColor: UIColor {
		return UIColor(14, 20, 26, 0.6)
	}

	open class var WePlaceholderTextColor: UIColor {
		return UIColor(14, 20, 26, 0.3)
	}

	open class var GoogleColor: UIColor {
		return UIColor(66, 133, 244, 1)
	}

	open class var FacebookColor: UIColor {
		return UIColor(59, 89, 152, 1)
	}

	open class var GithubColor: UIColor {
		return UIColor(25, 23, 23, 1)
	}
}
