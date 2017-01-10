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
		perform(actionName: LoginWithProviderInteractor.ActionName, params: ["provider" : "github", "redirectUri" : "wedeploy-app://"])
	}

	@IBAction func Login() {
		perform(actionName:  LoginInteractor.ActionName, params: ["username" : "test@test.com", "password" : "test"])
	}

	public override func interactionEnded(actionName: String, result: [String : Any]) {
		let user = result["user"] as! User
		
		label.text = "\(user)"

//		let data = try? Data(contentsOf: URL(string: user.photoUrl!)!)
//
//		profileImage.image = UIImage(data: data)
	}

	public override func interactionErrored(actionName: String, error: Error) {
		print(error)
	}
}
