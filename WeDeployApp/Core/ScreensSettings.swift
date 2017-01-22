//
//  ScreensSetting.swift
//  WeDeployApp
//
//  Created by Victor Galán on 22/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import Foundation
import RxSwift

public class ScreensSettings {
	public static let shared = ScreensSettings()

	fileprivate var settingsList: [String:  Any]

	private init?() {
		let path = Bundle.main.path(forResource: "screens-config", ofType: "plist")

		if let path = path {
			settingsList = NSDictionary(contentsOfFile: path) as! [String : Any]
		}
		else {
			print("no file named screens-config found")
			return nil
		}
	}

	public func stringProperty(for name: String) -> String {
		return settingsList[name] as! String
	}
}
