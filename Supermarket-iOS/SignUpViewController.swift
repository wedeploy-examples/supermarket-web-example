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

class SignUpViewController: BaseKeyboardViewController {


	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!

	@IBOutlet weak var bottomView: UIView! {
		didSet {
			bottomView.addWeDeployShadow()
		}
	}

	let weDeployClient = WeDeployAPIClient()

	@IBOutlet weak var signupButton: WeColorButton!

	@IBAction func signUpButtonClick(_ sender: Any) {
		guard let name = nameTextField.text, let email = emailTextField.text,
			let password = passwordTextField.text else { return }

		weDeployClient.register(with: email, password: password, name: name) { user, error in
			self.finishSignUp(user: user, error: error)
		}
	}

	@IBAction func signupWithProviderButtonClick(_ sender: WeProviderButton) {
		weDeployClient.login(with: sender.provider!, redirectUri: "my-app://") { user, error in
			self.finishSignUp(user: user, error: error)
		}
	}

	@IBAction func goToLoginButtonClick() {
		_ = self.navigationController?.popViewController(animated: true)
		let topVC = self.navigationController?.topViewController as? InitialViewController
		topVC?.goLogin = true
	}

	func finishSignUp(user: User?, error: Error?) {
		if let user = user {
			print("Signed up \(user)")

			self.floatingView.show(message: "Sign up correct!", error: false)

			DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
				self.performSegue(withIdentifier: "main", sender: nil)
			}
		}
		else {
			print("\(error!)")
			self.floatingView.show(message: "Sign up error", error: true)
		}
	}
}
