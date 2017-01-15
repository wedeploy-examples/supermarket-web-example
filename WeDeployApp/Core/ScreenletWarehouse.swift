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

	let loginInteractors: [String : Interactor.Type] = [
		LoginScreenlet.LoginActionName : LoginInteractor.self,
		LoginScreenlet.LoginWithProviderActionName : LoginWithProviderInteractor.self
	]

	let signUpInteractors: [String : Interactor.Type] = [
		SignUpScreenlet.CheckEmailAction: CheckEmailInteractor.self,
		SignUpScreenlet.CreateUserAction: CreateUserInteractor.self,
		LoginScreenlet.LoginWithProviderActionName: LoginWithProviderInteractor.self
	]

	private init() {
		definitions = [String : ScreenletDefinition]()
		definitions = [
			"LoginScreenlet" : ScreenletDefinition(interactors: loginInteractors, viewNames: ["WeLoginScreenletView"]),
			"ForgotPasswordScreenlet" : ScreenletDefinition(interactors: [ForgotPasswordScreenlet.ForgotPasswordAction : ForgotPasswordInteractor.self], viewNames: ["WeForgotPasswordScreenletView"]),
			"SignUpScreenlet" : ScreenletDefinition(interactors: signUpInteractors, viewNames: ["WeSignUpScreenletView"])
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
	let interactors: [String : Interactor.Type]
	let viewNames: [String]
}
