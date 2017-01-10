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

	var loginParams: LoginWithProviderInteractorInput!

	override var actionName: String {
		return LoginWithProviderInteractor.ActionName
	}

	public override func execute() -> Observable<InteractorOutput> {
	
		let authProvider =
				AuthProvider(provider: loginParams.provider, redirectUri: loginParams.redirectUri)

		return Observable.create { observer in
			WeDeploy.auth("auth.easley84.wedeploy.io")
				.signInWithRedirect(provider: authProvider) { (user, error) in
					if let user = user {
						observer.onNext(user)
					}
					else {
						observer.onError(error!)
					}
				}
				
			return Disposables.create()
		}
	}

	public override func validateParams() -> Bool {
		guard let loginParams = params as? LoginWithProviderInteractorInput
			else { return false }

		self.loginParams = loginParams

		return true
	}

	public override func support(actionName: String) -> Bool {
		return actionName == LoginWithProviderInteractor.ActionName
	}
}
