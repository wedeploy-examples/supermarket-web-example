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

class LoginViewController: BaseKeyboardViewController {

	@IBOutlet weak var bottomView: UIView! {
		didSet {
			bottomView.addWeDeployShadow()
		}
	}
	@IBOutlet weak var loginButton: WeColorButton!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var emailTextField: UITextField!

	let weDeployClient = WeDeployAPIClient()

	@IBAction func loginButtonClick() {
		guard let username = emailTextField.text, let password = passwordTextField.text else {
			print("you have to enter the username and password to log in")
			return
		}

		weDeployClient.login(with: username, password: password) { user, error in
			self.finishLogin(user: user, error: error)
		}
	}

	@IBAction func loginWithProviderClick(_ sender: WeProviderButton) {

		weDeployClient.login(with: sender.provider!, redirectUri: "my-app://") { user, error in
			self.finishLogin(user: user, error: error)
		}
	}

	func finishLogin(user: User?, error: Error?) {
		if let user = user {
			print("user logged \(user)")

			floatingView.show(message: "Login correct!", error: false)

			DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
				self.performSegue(withIdentifier: "main", sender: nil)
			}
		}
		else {
			print("\(error!)")
			floatingView.show(message: "Login error", error: true)
		}
	}

	@IBAction func goToSignUpButtonClick() {
		_ = self.navigationController?.popViewController(animated: true)
		let topVC = self.navigationController?.topViewController as? InitialViewController
		topVC?.goSingUp = true
	}
}
