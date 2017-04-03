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

class ForgotPasswordViewController: BaseKeyboardViewController {

	@IBOutlet weak var emailTextField: UITextField!

	let weDeployClient = WeDeployAPIClient()

	@IBAction func sendPasswordButtontClick() {
		guard let email = emailTextField.text else {
			return
		}
		
		weDeployClient.sendResetPassword(email: email) { success, error in
			if let _ = success {
				self.floatingView.show(message: "Email sent", error: false)
			}
			else {
				self.floatingView.show(message: "Failed to send email", error: true)
			}
		}
	}
}
