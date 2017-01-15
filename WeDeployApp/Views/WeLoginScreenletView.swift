//
//  WeLoginScreenletView.swift
//  WeDeployApp
//
//  Created by Victor Galán on 05/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import UIKit
import WeDeploy
import RxSwift
import RxCocoa

public class WeLoginScreenletView : BaseScreenletView {

	public static let GoToSignUpActionName = "GoToSignUpActionName"
	public static let GoToForgotPasswordActionName = "GoToForgotPasswordName"
	public static let GoBackActionName = "GoBack"

	@IBOutlet weak var emailTextField: BorderLessTextField!
	@IBOutlet weak var passwordTextField: BorderLessTextField!
	
	@IBOutlet weak var loginButton: WeColorButton!
	@IBOutlet weak var loginLabel: UILabel!

	@IBOutlet weak var bottomView: UIView!
	@IBOutlet weak var arrowBackButton: UIButton!

	@IBOutlet var providerButtons: [UIButton]!

	@IBOutlet weak var topConstraint: NSLayoutConstraint!
	@IBOutlet weak var bottomConstraint: NSLayoutConstraint!

	var initialBottomConstraintConstant: CGFloat!
	var initialTopContraintConstant: CGFloat!

	let floatingView = FloatingView()

	var disposeBag = DisposeBag()

	var keyboardDismisser: KeyboardDismisserOnClick?

	open override func awakeFromNib() {
		super.awakeFromNib()

		initialBottomConstraintConstant = bottomConstraint.constant
		initialTopContraintConstant = topConstraint.constant

		bottomView.layer.shadowColor = UIColor.black.cgColor
		bottomView.layer.shadowOffset = CGSize(width: 0, height: -1);
		bottomView.layer.shadowRadius = 5;
		bottomView.layer.shadowOpacity = 0.1;
		bottomView.layer.masksToBounds = false

		addSubview(floatingView)

		setupBindings()
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

	func setupBindings() {
		let formValid = Observable
			.combineLatest(emailTextField.rx.text.orEmpty, passwordTextField.rx.text.orEmpty) { (email, password) in
				return email.characters.count > 0 && password.characters.count > 0
		}

		formValid
			.bindTo(loginButton.rx.isEnabled)
			.addDisposableTo(disposeBag)
	}

	func showHideKeyboard(height: CGFloat) {

		let transform = height == 0 ? CGAffineTransform.identity : CGAffineTransform(scaleX: 0.7, y: 0.7)

		self.topConstraint.constant = height == 0 ? initialTopContraintConstant : CGFloat(26)
		self.bottomConstraint.constant = height == 0 ? initialBottomConstraintConstant! : height + 20
		
		UIView.animate(withDuration: 0.5) {
			self.loginLabel.transform = transform
			self.layoutIfNeeded()
		}
	}

	@IBAction func loginButtonClicked(_ sender: UIButton) {
		endEditing(false)
		sender.setTitle("Logging in...", for: .disabled)
		sender.isEnabled = false

		let interactorInput = LoginInteractorInput(username: emailTextField.text!, password: passwordTextField.text!)

		perform(actionName: LoginScreenlet.LoginActionName, params: interactorInput)
	}

	@IBAction func providerButtonClicked(_ sender: WeProviderButton) {
		sender.isEnabled = false

		let interactorInput = LoginWithProviderInteractorInput(provider: sender.provider!, redirectUri: "wedeploy-app://")
		self.perform(actionName: LoginScreenlet.LoginWithProviderActionName, params: interactorInput)
	}

	@IBAction func interactorlessActionButtonClicked(_ sender: UIButton) {
		perform(actionName: sender.restorationIdentifier ?? "")
	}

	override open func interactionEnded(actionName: String, result: InteractorOutput) {
		if actionName == LoginScreenlet.LoginActionName {
			loginButton.setTitle("Log in", for: .disabled)
			loginButton.isEnabled = true

            floatingView.show(message: "Login successful", error: false)
		}
		else if actionName == LoginScreenlet.LoginWithProviderActionName {
			providerButtons.forEach { $0.isEnabled = true }
			floatingView.show(message: "Login successful", error: false)
		}
	}
    
    override open func interactionErrored(actionName: String, error: Error) {
		print(error)
        if actionName == LoginScreenlet.LoginActionName {
            emailTextField.setErrorAppearance()
            passwordTextField.setErrorAppearance()
            loginButton.setTitle("Log in", for: .disabled)
            loginButton.isEnabled = true

            
            floatingView.show(message: "Ops, invalid password or email.", error: true)
        }
    }

}
