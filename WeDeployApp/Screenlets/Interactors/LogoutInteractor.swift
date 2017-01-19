//
//  LogoutInteractor.swift
//  WeDeployApp
//
//  Created by Victor Galán on 19/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import Foundation
import WeDeploy
import RxSwift


open class LogoutInteractor : Interactor {

	open override func execute() -> Observable<InteractorOutput> {
		WeDeploy.auth().signOut()

		return Observable.just("")
	}

	open override func validateParams() -> Bool {
		return true
	}
}
