//
//  ForgotPasswordInteractor.swift
//  WeDeployApp
//
//  Created by Victor Galán on 12/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import Foundation
import WeDeploy
import RxSwift

struct ForgotPasswordInteractorInput : InteractorInput {
	let email: String
}

extension String : InteractorOutput { }

open class ForgotPasswordInteractor : Interactor {

	var forgotPasswordParams: ForgotPasswordInteractorInput!

	open override func execute() -> Observable<InteractorOutput> {

		return WeDeploy.auth("auth.easley84.wedeploy.io")
				.sendPasswordReset(email: forgotPasswordParams.email)
				.toObservable()
				.map { "" }
	}

	open override func validateParams() -> Bool {
		guard let forgotPasswordParams = params as? ForgotPasswordInteractorInput
			else { return false }

		self.forgotPasswordParams = forgotPasswordParams

		return true
	}
	
}
