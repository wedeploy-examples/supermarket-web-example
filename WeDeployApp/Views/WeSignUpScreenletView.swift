//
//  WeSignUpScreenletView.swift
//  WeDeployApp
//
//  Created by Victor Galán on 13/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import WeDeploy

class WeSignUpScreenletView: BaseScreenletView {

	public static let GoToLoginAction = "GoToLoginActionName"

	@IBOutlet weak var topConstraint: NSLayoutConstraint!
	@IBOutlet weak var bottomConstraint: NSLayoutConstraint!

	var initialBottomConstraintConstant: CGFloat!
	var initialTopContraintConstant: CGFloat!

	@IBOutlet weak var progressView: UIProgressView! {
		didSet {
			progressView.progressTintColor = .mainColor
			progressView.trackTintColor = .WeTextFieldBackgroundColor
		}
	}

	@IBOutlet weak var bottomView: UIView! {
		didSet {
			bottomView.layer.shadowColor = UIColor.black.cgColor
			bottomView.layer.shadowOffset = CGSize(width: 0, height: -1);
			bottomView.layer.shadowRadius = 5;
			bottomView.layer.shadowOpacity = 0.1;
			bottomView.layer.masksToBounds = false
		}
	}

	@IBOutlet weak var nextButton: WeColorButton!

	@IBOutlet weak var previousButton: UIButton! {
		didSet {
			previousButton.backgroundColor = .WeTextFieldBackgroundColor
			previousButton.setTitleColor(.WeTextColor, for: .normal)
			previousButton.titleLabel?.font = UIFont.boldWeFont(ofSize: 16)
			previousButton.layer.cornerRadius = 4
		}
	}
	@IBOutlet weak var bigText: UILabel!

	@IBOutlet weak var editText: BorderLessTextField!

	@IBOutlet weak var signUpLabel: UILabel!
	var progressNum = 0

	var disposeBag = DisposeBag()
	var keyboardDismisser: KeyboardDismisserOnClick?

	var name: String = ""
	var email: String = ""
	var password: String = ""

	var user: User?

	let floatingView = FloatingView()

	override func awakeFromNib() {
		super.awakeFromNib()

		addSubview(floatingView)

		if UIScreen.main.bounds.height < 570 {
			bottomConstraint.constant = 180
			topConstraint.constant = 130
		}

		keyboardDismisser = KeyboardDismisserOnClick(forView: self)

		initialBottomConstraintConstant = bottomConstraint.constant
		initialTopContraintConstant = topConstraint.constant

		editText.rx.text.orEmpty.map { $0.characters.count > 1 }
			.bindTo(nextButton.rx.isEnabled)
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
			self.signUpLabel.transform = transform
			self.layoutIfNeeded()
		}
	}
	
	@IBAction func nextButtonClicked(_ sender: UIButton) {
		if sender.tag == 0 && progressNum == 0 {
			return
		}

		if sender.tag == 1 && progressNum == 1 {
			performCheckEmailAction()
			return
		}

		if sender.tag == 1 && progressNum == 2 {
			performSignUpAction()
			return
		}

		progressNum += sender.tag == 0 ? -1: 1

		moveToNextStep()
	}

	func moveToNextStep() {
		nextButton.isEnabled = false

		UIView.animate(withDuration: 0.3, animations: {
			self.bigText.alpha = 0
			self.editText.alpha = 0
		}, completion: { _ in
			self.setState(num: self.progressNum)
			self.editText.text = ""
		})

		UIView.animate(withDuration: 0.3, delay: 0.3, options: [], animations: {
			self.bigText.alpha = 1
			self.editText.alpha = 1
		}, completion: nil)
	}

	func setState(num: Int) {
		if num == 0 {
			progressView.setProgress(0.33, animated: true)
			editText.placeholder = "Your full name"
			bigText.text = "What is your name?"
		}
		else if num == 1 {
			name = editText.text ?? ""
			progressView.setProgress(0.66, animated: true)
			editText.placeholder = "email address"
			bigText.text = "And your email?"
			editText.isPasswordField = false
			nextButton.setTitle("Next", for: .normal)
		}
		else if num == 2 {
			progressView.setProgress(1, animated: true)
			editText.placeholder = "password"
			bigText.text = "Now, create a password"
			editText.isPasswordField = true
			nextButton.setTitle("Sign up", for: .normal)
		}
	}

	func performSignUpAction() {
		self.password = editText.text ?? ""

		let input = CreateUserInteractorInput(id: user!.id, email: self.email, name: self.name, password: self.password)

		perform(actionName: SignUpScreenlet.CreateUserAction, params: input)
	}

	func performCheckEmailAction() {
		self.email = editText.text ?? ""
		let input = CheckEmailInteractorInput(email: email, name: name)
		perform(actionName: SignUpScreenlet.CheckEmailAction, params: input)
	}

	override func interactionStarted(actionName: String) {
		if actionName == SignUpScreenlet.CheckEmailAction {
			previousButton.isEnabled = false
			nextButton.setTitle("Checking...", for: .disabled)
			nextButton.isEnabled = false
		}
		else if actionName == SignUpScreenlet.CreateUserAction {
			previousButton.isEnabled = false
			nextButton.setTitle("Signing up...", for: .disabled)
			nextButton.isEnabled = false
			endEditing(false)
		}
	}

	override func interactionEnded(actionName: String, result: InteractorOutput) {
		if actionName == SignUpScreenlet.CheckEmailAction {
			user = result as? User
			previousButton.isEnabled = true
			nextButton.setTitle("Sign Up", for: .disabled)

			progressNum += 1

			floatingView.hide()

			_ = editText.becomeFirstResponder()

			moveToNextStep()
		}
	}

	override func interactionErrored(actionName: String, error: Error) {
		if actionName == SignUpScreenlet.CheckEmailAction {
			floatingView.show(message: "That email is already in use. Please, try a different one.", error: true)

			nextButton.setTitle("Next", for: .disabled)
			nextButton.isEnabled = true

			previousButton.isEnabled = true

			editText.setErrorAppearance()
		}
	}

	@IBAction func interactionLessButtonClick(_ sender: UIButton) {
		perform(actionName: sender.restorationIdentifier!)
	}

	@IBAction func providerButtonClicked(_ sender: WeProviderButton) {
		sender.isEnabled = false

		let interactorInput = LoginWithProviderInteractorInput(
				provider: sender.provider!,
				redirectUri: "wedeploy-app://")

		self.perform(actionName: LoginScreenlet.LoginWithProviderActionName, params: interactorInput)
	}
}
