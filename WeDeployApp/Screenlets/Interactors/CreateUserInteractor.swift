//
//  CreateUserIneractor.swift
//  WeDeployApp
//
//  Created by Victor Galán on 14/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import Foundation
import WeDeploy
import RxSwift

public struct CreateUserInteractorInput : InteractorInput {

	let id: String
	let email: String
	let name: String
	let password: String

}


public class CreateUserInteractor : Interactor {

	var createUserParams: CreateUserInteractorInput!

	open override func execute() -> Observable<InteractorOutput> {
		return WeDeploy.auth()
			.signInWith(username: createUserParams.email, password: "1234")
			.toObservable()
			.flatMap { _ in
				return WeDeploy.auth()
					.updateUser(
							id: self.createUserParams.id,
							email: self.createUserParams.email,
							password: self.createUserParams.password,
							name: self.createUserParams.name)
					.toObservable()
			}
			.map { _ in
				return WeDeploy.auth().currentUser!
			}
	}

	open override func validateParams() -> Bool {
		guard let createUserParams = params as? CreateUserInteractorInput else { return false }

		self.createUserParams = createUserParams

		return true
	}
}
