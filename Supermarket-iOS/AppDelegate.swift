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


import UIKit
import WeDeploy

struct WeDeployConfig {

	static let authUrl = "https://auth-supermarket.wedeploy.sh"
	static let dataUrl = "https://data-supermarket.wedeploy.sh"
	static let emailUrl = "https://email-supermarket.wedeploy.sh"
	static let webUrl = "https://ui-supermarket.wedeploy.sh"
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

		return true
	}

	func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
		WeDeploy.auth(WeDeployConfig.authUrl).handle(url: url)
		return true
	}
}

