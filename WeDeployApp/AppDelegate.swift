//
//  AppDelegate.swift
//  WeDeployApp
//
//  Created by Victor Galán on 05/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import UIKit
import WeDeploy

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		return true
	}

	func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
		WeDeploy.auth().handle(url: url)
		return true
	}

}

