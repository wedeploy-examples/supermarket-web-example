//
//  LoginWithProviderInteractor.swift
//  WeDeployApp
//
//  Created by Victor Galán on 05/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import Foundation
import WeDeploy
import RxSwift

public class LoginWithProviderInteractor : Interactor {

	static let ActionName = "LoginWithProviderAction"

	var provider: AuthProvider.Provider?
	var redirectUri: String?
	var scope: String?
	var providerScope: String?

	override var actionName: String {
		return LoginWithProviderInteractor.ActionName
	}

	public override func execute() -> Observable<[String : Any]> {
	
		let authProvider = AuthProvider(provider: provider!, redirectUri: redirectUri!)

		return Observable.create { observer in
			WeDeploy.auth("auth.easley84.wedeploy.io")
				.signInWithRedirect(provider: authProvider) { (user, error) in
					if let user = user {
						observer.onNext(["user" : user])
					}
					else {
						observer.onError(error!)
					}
				}
				
			return Disposables.create()
		}
	}

	public override func validateParams() -> Bool {
		guard let providerName = params["provider"] as? String,
			let provider = AuthProvider.Provider(rawValue: providerName),
			let redirectUri = params["redirectUri"] as? String else {
				return false
		}

		self.provider = provider
		self.providerScope = params["providerScope"] as? String
		self.scope = params["scope"] as? String
		self.redirectUri = redirectUri

		return true
	}

	public override func support(actionName: String) -> Bool {
		return actionName == LoginWithProviderInteractor.ActionName
	}
}
