//
//  ScreenletDefinition.swift
//  WeDeployApp
//
//  Created by Victor Galán on 09/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import Foundation


public class ScreenletWarehouse {
	public static let shared = ScreenletWarehouse()

	internal var definitions: [String : ScreenletDefinition]

	private init() {
		definitions = [String : ScreenletDefinition]()
		definitions = [
			"LoginScreenlet" : ScreenletDefinition(interactors: [LoginWithProviderInteractor(), LoginInteractor()], viewNames: ["WeLoginScreenletView"], classType: LoginScreenlet.self)
		]
	}

	func definitionFor(screenlet: BaseScreenlet.Type) -> ScreenletDefinition? {
		let name = screenletName(screenlet)
		return definitions[name]
	}

	public func createDefinitionFor(screenlet: BaseScreenlet.Type, definition: ScreenletDefinition) {
		
	}

	func screenletName(_ name: BaseScreenlet.Type) -> String {
		return "\(name)"
	}
}

public struct ScreenletDefinition {
	let interactors: [Interactor]
	let viewNames: [String]
	let classType: BaseScreenlet.Type
}
