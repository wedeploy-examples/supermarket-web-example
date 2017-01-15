//
//  SignUpScreenlet.swift
//  WeDeployApp
//
//  Created by Victor Galán on 13/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import UIKit
import WeDeploy
import RxSwift


public enum SignUpDelegate {
	case userCreated(User)
	case actionStarted(String)
	case error(Error)
}

class SignUpScreenlet: BaseScreenlet {

	public static let CheckEmailAction = "CheckEmailAction"
	public static let CreateUserAction = "CreateUserAction"

	var delegate = PublishSubject<SignUpDelegate>()

	override open func interactionStarted(actionName: String) {
		delegate.onNext(.actionStarted(actionName))
		super.interactionStarted(actionName: actionName)
	}

	override open func interactionEnded(actionName: String, result: InteractorOutput) {
		if actionName == SignUpScreenlet.CreateUserAction || actionName == LoginScreenlet.LoginWithProviderActionName  {
			delegate.onNext(.userCreated(result as! User))
		}

		super.interactionEnded(actionName: actionName, result: result)
	}

	override open func interactionErrored(actionName: String, error: Error) {
		if actionName == LoginScreenlet.LoginActionName ||
			actionName == LoginScreenlet.LoginWithProviderActionName {

			delegate.onNext(.error(error))
		}

		super.interactionErrored(actionName: actionName, error: error)
	}

	
}
