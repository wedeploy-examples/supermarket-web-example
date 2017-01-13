//
//  ForgotPasswordScreenlet.swift
//  WeDeployApp
//
//  Created by Victor Galán on 12/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import UIKit
import RxSwift

public enum ForgotPasswordDelegate {
	case emailSent
	case actionStarted(String)
	case error(Error)
}

open class ForgotPasswordScreenlet: BaseScreenlet {

	public static let ForgotPasswordAction = "ForgotPasswordAction"

	var delegate = PublishSubject<ForgotPasswordDelegate>()

	override open func interactionStarted(actionName: String) {
		delegate.onNext(.actionStarted(actionName))
	}

	override open func interactionEnded(actionName: String, result: InteractorOutput) {
		if actionName == ForgotPasswordScreenlet.ForgotPasswordAction {
			delegate.onNext(.emailSent)
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
