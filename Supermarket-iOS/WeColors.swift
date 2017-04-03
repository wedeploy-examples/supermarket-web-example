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

extension UIColor {

	@nonobjc public static var mainColor = UIColor(0, 164, 255, 1)
	
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
