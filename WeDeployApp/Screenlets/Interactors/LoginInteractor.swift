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

public class LoginInteractor : Interactor {

	public static let ActionName = "LoginAction"

	var username: String?
	var password: String?

	override var actionName: String {
		return LoginInteractor.ActionName
	}

	public override func execute() -> Observable<[String : Any]> {

		return WeDeploy.auth("auth.easley84.wedeploy.io")
			.signInWith(username: username!, password: password!)
			.toObservable()
			.map { user in
				print(Thread.isMainThread)
				return ["user" : user]
			}
	}

	public override func validateParams() -> Bool {
		guard let username = params["username"] as? String,
			let password = params["password"] as? String else {
				return false
		}

		self.username = username
		self.password = password

		return true
	}

	public override func support(actionName: String) -> Bool {
		return actionName == LoginInteractor.ActionName
	}
	
}
