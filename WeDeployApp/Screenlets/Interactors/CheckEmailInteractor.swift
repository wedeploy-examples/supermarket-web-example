//
//  CheckEmailInteractor.swift
//  WeDeployApp
//
//  Created by Victor Galán on 14/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import Foundation
import WeDeploy
import RxSwift

public struct CheckEmailInteractorInput : InteractorInput {

	let email: String
	let name: String

}

open class CheckEmailInteractor : Interactor {

	var checkEmailParams: CheckEmailInteractorInput!

	open override func execute() -> Observable<InteractorOutput> {
		return WeDeploy.auth("auth.easley84.wedeploy.io")
			.createUser(email: checkEmailParams.email, password: "1234", name: checkEmailParams.name)
			.toObservable()
			.map { user in
				return user
			}
	}

	open override func validateParams() -> Bool {
		guard let checkEmailParams = params as? CheckEmailInteractorInput else { return false }

		self.checkEmailParams = checkEmailParams

		return true
	}
}
