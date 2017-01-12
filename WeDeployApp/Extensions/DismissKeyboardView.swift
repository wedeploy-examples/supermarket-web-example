//
//  DismissKeyboardView.swift
//  WeDeployApp
//
//  Created by Victor Galán on 11/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import UIKit

@objc public class KeyboardDismisserOnClick: NSObject {

	weak var view: UIView?

	init(forView view: UIView) {
		self.view = view
		super.init()
		
		let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
		view.addGestureRecognizer(gesture)
	}

	func dismissKeyboard() {
		view?.endEditing(false)
	}

}
