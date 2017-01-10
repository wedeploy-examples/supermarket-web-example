//
//  WeLoginScreenletView.swift
//  WeDeployApp
//
//  Created by Victor Galán on 05/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import UIKit
import WeDeploy

public class WeLoginScreenletView : BaseScreenletView {

	@IBOutlet weak var profileImage: UIImageView!
	@IBOutlet weak var label: UILabel!

	@IBAction func buttonClick(_ sender: Any) {
		let params = LoginWithProviderInteractorInput(provider: .github, redirectUri: "wedeploy-app://")
		perform(actionName: LoginScreenlet.LoginWithProviderActionName, params: params)
	}

	@IBAction func Login() {
		let params = LoginInteractorInput(username: "test@test.com", password: "test")
		perform(actionName:  LoginScreenlet.LoginActionName, params: params)
	}

	public override func interactionEnded(actionName: String, result: InteractorOutput) {
		let user = result as! User
		
		label.text = "\(user)"

//		let data = try? Data(contentsOf: URL(string: user.photoUrl!)!)
//
//		profileImage.image = UIImage(data: data)
	}

	public override func interactionErrored(actionName: String, error: Error) {
		print(error)
	}
}
