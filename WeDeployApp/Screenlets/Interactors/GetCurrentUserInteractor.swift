//
//  File.swift
//  WeDeployApp
//
//  Created by Victor Galán on 18/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import Foundation
import WeDeploy
import RxSwift

public enum GetCurrentUserInteractorError : Error {
	case userNotLoggedIn
}

public class GetCurrentUserInteractor : Interactor {

	public override func execute() -> Observable<InteractorOutput> {
		guard let user = WeDeploy.auth().currentUser else {
			return Observable.error(GetCurrentUserInteractorError.userNotLoggedIn)
		}
		return Observable.just(user)
	}

	public override func validateParams() -> Bool {
		return true
	}
}
