//
//  LoginInteractor.swift
//  WeDeployApp
//
//  Created by Victor Galán on 09/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import Foundation
import WeDeploy
import RxSwift

extension User : InteractorOutput { }

public class LoginInteractor : Interactor {

	public static let ActionName = "LoginAction"

	var loginParams: LoginInteractorInput!

	override var actionName: String {
		return LoginInteractor.ActionName
	}

	public override func execute() -> Observable<InteractorOutput> {

		return WeDeploy.auth("auth.easley84.wedeploy.io")
			.signInWith(username: loginParams.username, password: loginParams.password)
			.toObservable()
			.map { user in
				return user
			}
	}

	public override func validateParams() -> Bool {
		guard let loginParams = params as? LoginInteractorInput
			else { return false }

		self.loginParams = loginParams
		
		return true
	}

	public override func support(actionName: String) -> Bool {
		return actionName == LoginInteractor.ActionName
	}
	
}
