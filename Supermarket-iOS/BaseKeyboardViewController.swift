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

class BaseKeyboardViewController: UIViewController {

	@IBOutlet weak var topConstraint: NSLayoutConstraint!
	@IBOutlet weak var bottomConstraint: NSLayoutConstraint!
	@IBOutlet weak var viewToTransform: UIView!

	@IBOutlet weak var backButton: UIButton?

	var initialBottomConstraintConstant: CGFloat!
	var initialTopContraintConstant: CGFloat!

	let floatingView = FloatingView()

	override func viewDidLoad() {
		super.viewDidLoad()

		view.addSubview(floatingView)

		initialTopContraintConstant = topConstraint.constant
		initialBottomConstraintConstant = bottomConstraint.constant

		let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
		view.addGestureRecognizer(gesture)

		backButton?.addTarget(self, action: #selector(back), for: .touchUpInside)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		NotificationCenter.default.addObserver(self, selector: #selector(notificationHandler),
			name: .UIKeyboardWillShow, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(notificationHandler),
		 	name: .UIKeyboardWillChangeFrame, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(notificationHandler),
			name: .UIKeyboardWillHide, object: nil)
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)

		NotificationCenter.default.removeObserver(self)
	}

	func dismissKeyboard() {
		view?.endEditing(false)
	}

	func back() {
		navigationController?.popViewController(animated: true)
	}

	func notificationHandler(notification: Notification) {
		if notification.name == .UIKeyboardWillShow ||
			notification.name == .UIKeyboardWillChangeFrame {

			let rectValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue
			showHideKeyboard(height: rectValue?.cgRectValue.height ?? 0)
		}
		else {
			showHideKeyboard(height: 0)
		}
	}

	func showHideKeyboard(height: CGFloat) {

		let transform = height == 0 ? CGAffineTransform.identity : CGAffineTransform(scaleX: 0.7, y: 0.7)

		self.topConstraint.constant = height == 0 ? initialTopContraintConstant : CGFloat(26)
		self.bottomConstraint.constant = height == 0 ? initialBottomConstraintConstant! : height + 20

		UIView.animate(withDuration: 0.5) {
			self.viewToTransform.transform = transform
			self.view.layoutIfNeeded()
		}
	}
}

