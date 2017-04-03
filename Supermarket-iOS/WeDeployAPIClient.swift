/**
* Copyright (c) 2000-present Liferay, Inc. All rights reserved.
*
* This library is free software; you can redistribute it and/or modify it under
* the terms of the GNU Lesser General Public License as published by the Free
* Software Foundation; either version 2.1 of the License, or (at your option)
* any later version.
*
* This library is distributed in the hope that it will be useful, but WITHOUT
* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
* FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
* details.
*/


import Foundation
import WeDeploy


struct WeDeployAPIClient {
	
	func login(with username: String, password: String, completion: @escaping (User?, Error?) -> Void) {
		WeDeploy.auth(WeDeployConfig.authUrl)
			.signInWith(username: username, password: password)
			.toCallback { auth, error in
				if let auth = auth {
					AppDelegate.currentAuth = auth
					WeDeploy.auth(WeDeployConfig.authUrl)
						.authorize(auth: auth)
						.getCurrentUser()
						.toCallback(callback: completion)
				}
				else {
					completion(nil, error)
				}
			}
	}

	func login(with provider: AuthProvider.Provider, redirectUri: String,
		completion: @escaping (User?, Error?) -> Void ) {

		let authProvider = AuthProvider(provider: provider, redirectUri: redirectUri)

		WeDeploy.auth(WeDeployConfig.authUrl)
			.signInWithRedirect(provider: authProvider) { auth, error in
				if let auth = auth {
					AppDelegate.currentAuth = auth
					WeDeploy.auth(WeDeployConfig.authUrl)
						.authorize(auth: auth)
						.getCurrentUser()
						.toCallback(callback: completion)
				}
				else {
					completion(nil, error)
				}
		}
	}

	func register(with email: String, password: String, name: String,
		completion: @escaping (User?, Error?) -> Void) {

		WeDeploy.auth(WeDeployConfig.authUrl)
			.createUser(email: email, password: password, name: name)
			.toCallback { user, error in
				if let user = user {
					AppDelegate.currentUser = user
					WeDeploy.auth(WeDeployConfig.authUrl)
						.signInWith(username: email, password: password)
						.toCallback { auth, error in
							if let auth = auth {
								AppDelegate.currentAuth = auth

								completion(user, nil)
							}
							else {
								completion(nil, error)
							}
						}
				}
				else {
					completion(nil, error)
				}
			}
	}

	func sendResetPassword(email: String, completion: @escaping (Void?, Error?) -> Void) {
		WeDeploy.auth(WeDeployConfig.authUrl)
			.sendPasswordReset(email: email).toCallback(callback: completion)
	}

	func loadProducts(category: String, completion: @escaping ([[String: AnyObject]]?, Error?) -> Void) {
		let wedeploy = WeDeploy.data(WeDeployConfig.dataUrl)

		if category != "all" {
			_ = wedeploy.where(field: "type", op: "=", value: category)
		}

		wedeploy.get(resourcePath: "products")
			.toCallback(callback: completion)

	}
}
