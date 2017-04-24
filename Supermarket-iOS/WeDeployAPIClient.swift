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
import PromiseKit


struct WeDeployAPIClient {

	let settings: Settings

	init(settings: Settings = .shared) {
		self.settings = settings
	}
	
	func login(with username: String, password: String, completion: @escaping (User?, Error?) -> Void) {

		WeDeploy.auth(WeDeployConfig.authUrl)
			.signInWith(username: username, password: password)
			.then { auth -> Promise<User> in
				self.settings.saveAuth(auth: auth)

				return WeDeploy.auth(WeDeployConfig.authUrl, authorization: auth)
					.getCurrentUser()
			}
			.then { user -> Void in
				self.settings.saveUser(user: user)

				completion(user, nil)
			}
			.catch { error in
				completion(nil, error)
			}
	}

	func login(with provider: AuthProvider.Provider, redirectUri: String,
		completion: @escaping (User?, Error?) -> Void ) {

		let authProvider = AuthProvider(provider: provider, redirectUri: redirectUri)

		WeDeploy.auth(WeDeployConfig.authUrl)
			.signInWithRedirect(provider: authProvider) { auth, error in
				if let auth = auth {
					self.settings.saveAuth(auth: auth)
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
			.then { user -> Promise<Auth> in
				self.settings.saveUser(user: user)

				return WeDeploy.auth(WeDeployConfig.authUrl)
					.signInWith(username: email, password: password)
			}
			.then { auth -> Void in
				self.settings.saveAuth(auth: auth)

				completion(self.settings.user, nil)
			}
			.catch { error in
				completion(nil, error)
			}
	}

	func sendResetPassword(email: String, completion: @escaping (Void?, Error?) -> Void) {
		WeDeploy.auth(WeDeployConfig.authUrl)
			.sendPasswordReset(email: email)
			.toCallback(callback: completion)
	}

	func loadProducts(category: String, completion: @escaping ([Product]?, Error?) -> Void) {
		let auth = settings.auth
		let wedeploy = WeDeploy.data(WeDeployConfig.dataUrl, authorization: auth)

		if category != "all" {
			_ = wedeploy.where(field: "type", op: "=", value: category)
		}

		wedeploy.get(resourcePath: "products")
			.then { json -> Void in
				let products = json.map(Product.init).flatMap { $0 }
				completion(products, nil)
			}
			.catch { error in
				completion(nil, error)
			}
	}

	func loadCartProducts(completion: @escaping ([ProductCart]?, Error?) -> Void) {
		let currentUser = settings.user!
		let auth = settings.auth

		WeDeploy.data(WeDeployConfig.dataUrl, authorization: auth)
			.where(field: "userId", op: "=", value: currentUser.id)
			.get(resourcePath: "cart")
			.toCallback { json, error in
				guard let json = json else {
					completion(nil, error)
					return
				}
				let products = json.map(ProductCart.init).flatMap { $0 }
				let productQuantity = products.reduce([ProductCart]()) { acc, product in
					if let product = acc.filter ({ p in p == product }).first {
						product.ids.append(product.id)
						return acc
					}
					else {
						return acc + [product]
					}
				}


				completion(productQuantity, nil)
			}
	}

	func addCartItem(product: ProductCart, completion: ((ProductCart?, Error?) -> Void)? = nil) {
		let auth = settings.auth

		WeDeploy.data(WeDeployConfig.dataUrl, authorization: auth)
			.create(resource: "cart", object: product.toJson())
			.then { json in
				completion?(ProductCart(json: json), nil)
			}
			.catch { error in
				completion?(nil, error)
			}
	}

	func removeCartItem(id: String, completion: @escaping (Void) -> Void) {
		let auth = settings.auth

		WeDeploy.data(WeDeployConfig.dataUrl, authorization: auth)
			.delete(collectionOrResourcePath: "cart/\(id)")
			.tap { _ in
				completion()
			}
	}

	func sendCheckoutEmail(products: [ProductCart]) {
		let auth = settings.auth
		let email = settings.user?.email ?? ""
		let message = products.reduce("") { acc, element in
			acc + "\n\(element.name): $\(element.price) x\(element.ids.count)"
		}

		_ = WeDeploy.email(WeDeployConfig.emailUrl, authorization: auth)
			.from("auto-confirm@supermarket.wedeploy.io")
			.to(email)
			.subject("Your order")
			.message(message)
			.send()
	}
}
