//
//  WeFonts.swift
//  WeDeployApp
//
//  Created by Victor Galán on 21/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

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
