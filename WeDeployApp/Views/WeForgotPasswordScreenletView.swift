//
//  WeForgotPasswordScreenletView.swift
//  WeDeployApp
//
//  Created by Victor Galán on 12/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WeForgotPasswordScreenletView: BaseScreenletView {

	@IBOutlet weak var emailTextField: BorderLessTextField!
	@IBOutlet weak var sendResetButton: WeColorButton!

	@IBOutlet weak var topConstraint: NSLayoutConstraint!
	@IBOutlet weak var bottomConstraint: NSLayoutConstraint!

	@IBOutlet weak var resetPasswordLabel: UILabel!
	
	var initialBottomConstraintConstant: CGFloat!
	var initialTopContraintConstant: CGFloat!

	var disposeBag = DisposeBag()

	var keyboardDismisser: KeyboardDismisserOnClick?

	let floatingView = FloatingView()
	
	override func awakeFromNib() {
		super.awakeFromNib()

		if UIScreen.main.bounds.height < 570 {
			bottomConstraint.constant = 180
			topConstraint.constant = 130
		}

		initialBottomConstraintConstant = bottomConstraint.constant
		initialTopContraintConstant = topConstraint.constant

		addSubview(floatingView)

		emailTextField.rx.text.orEmpty
			.map { $0.characters.count > 1 }
			.bindTo(sendResetButton.rx.isEnabled)
			.addDisposableTo(disposeBag)

		setupKeyboardStuff()
	}

	func setupKeyboardStuff() {
		keyboardDismisser = KeyboardDismisserOnClick(forView: self)

		NotificationCenter.default.rx.notification(.UIKeyboardWillShow)
			.map { notification -> CGRect in
				let rectValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue
				return rectValue?.cgRectValue ?? CGRect.zero
			}
			.subscribe(onNext: { [weak self] frame in
				self?.showHideKeyboard(height: frame.height)
			})
			.addDisposableTo(disposeBag)

		NotificationCenter.default.rx.notification(.UIKeyboardWillChangeFrame)
			.map { notification -> CGRect in
				let rectValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue
				return rectValue?.cgRectValue ?? CGRect.zero
			}
			.subscribe(onNext: { [weak self] frame in
				self?.showHideKeyboard(height: frame.height)
			})
			.addDisposableTo(disposeBag)

		NotificationCenter.default.rx.notification(.UIKeyboardWillHide)
			.subscribe(onNext: { [weak self] _ in
				self?.showHideKeyboard(height: 0)
			})
			.addDisposableTo(disposeBag)
	}

	func showHideKeyboard(height: CGFloat) {

		let transform = height == 0 ? CGAffineTransform.identity : CGAffineTransform(scaleX: 0.7, y: 0.7)

		self.topConstraint.constant = height == 0 ? initialTopContraintConstant : CGFloat(26)
		self.bottomConstraint.constant = height == 0 ? initialBottomConstraintConstant! : height + 20

		UIView.animate(withDuration: 0.5) {
			self.resetPasswordLabel.transform = transform
			self.layoutIfNeeded()
		}
	}

	@IBAction func backButtonClicked(_ sender: UIButton) {

		perform(actionName: sender.restorationIdentifier!)
	}

	@IBAction func sendResetButtonClicked(_ sender: UIButton) {
		let interactorInput = ForgotPasswordInteractorInput(email: emailTextField.text!)
		sender.setTitle("Sending email...", for: .disabled)
		sender.isEnabled = false
		endEditing(false)

		perform(actionName: ForgotPasswordScreenlet.ForgotPasswordAction, params: interactorInput)
	}

	override func interactionEnded(actionName: String, result: InteractorOutput) {
		if actionName == ForgotPasswordScreenlet.ForgotPasswordAction {
			floatingView.show(message: "The email should arrive within a few minutes", error: false)
			sendResetButton.isEnabled = true
		}
	}

	override func interactionErrored(actionName: String, error: Error) {
		if actionName == ForgotPasswordScreenlet.ForgotPasswordAction {
			floatingView.show(message: "Ops, an error ocurred while sending the email", error: true)
			sendResetButton.isEnabled = true
		}
	}
	
}
