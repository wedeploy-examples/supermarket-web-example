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


public extension UIFont {

	public class func weFont(ofSize fontSize: CGFloat) -> UIFont {
		return UIFont(name: "GalanoGrotesque-Medium", size: fontSize)!
	}

	public class func semiboldWeFont(ofSize fontSize: CGFloat) -> UIFont {
		return UIFont(name: "GalanoGrotesque-SemiBold", size: fontSize)!
	}

	public class func boldWeFont(ofSize fontSize: CGFloat) -> UIFont {
		return UIFont(name: "GalanoGrotesque-Bold", size: fontSize)!
	}

	public class func iconFont12px(ofSize fontSize: CGFloat) -> UIFont {
		return UIFont(name: "loop-icons-12px", size: fontSize)!
	}

	public class func iconFont16px(ofSize fontSize: CGFloat) -> UIFont {
		return UIFont(name: "loop-icons-16px", size: fontSize)!
	}
}
