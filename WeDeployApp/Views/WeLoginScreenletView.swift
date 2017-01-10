//
//  WeLoginScreenletView.swift
//  WeDeployApp
//
//  Created by Victor Galán on 05/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import UIKit
import WeDeploy
import RxCocoa

public class WeLoginScreenletView : BaseScreenletView {

//	@IBOutlet weak var profileImage: UIImageView!
//	@IBOutlet weak var label: UILabel!
//
//	@IBAction func buttonClick(_ sender: Any) {
//		let params = LoginWithProviderInteractorInput(provider: .github, redirectUri: "wedeploy-app://")
//		perform(actionName: LoginScreenlet.LoginWithProviderActionName, params: params)
//	}
//
//	@IBAction func Login() {
//		let params = LoginInteractorInput(username: "test@test.com", password: "test")
//		perform(actionName:  LoginScreenlet.LoginActionName, params: params)
//	}
	@IBOutlet weak var textField: BorderLessTextField!
	@IBOutlet weak var button: WeButton!


	public override func awakeFromNib() {
		super.awakeFromNib()

		textField.rx.text.orEmpty.map { $0.characters.count > 0 }.bindTo(button.rx.isEnabled)
	}

}
