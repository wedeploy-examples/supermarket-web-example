//
//  LoginInteractorParams.swift
//  WeDeployApp
//
//  Created by Victor Galán on 10/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import Foundation
import WeDeploy

public struct LoginInteractorInput : InteractorInput {
	let username: String
	let password: String
}

public struct LoginWithProviderInteractorInput : InteractorInput {

	let provider: AuthProvider.Provider
	let redirectUri: String
	let scope: String?
	let providerScope: String?

	init(provider: AuthProvider.Provider, redirectUri: String,
			scope: String? = nil, providerScope: String? = nil) {

		self.provider = provider
		self.redirectUri = redirectUri
		self.scope = scope
		self.providerScope = providerScope
	}

}
