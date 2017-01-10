//
//  Interactor.swift
//  WeDeployApp
//
//  Created by Victor Galán on 05/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import Foundation
import RxSwift


public enum InteractorError: Error {
	case invalidParams
}


public class Interactor {

	var params: InteractorInput!

	public required init() {
	}

	public func start(params: InteractorInput) -> Observable<InteractorOutput> {
		self.params = params
		if !validateParams() {
			return Observable.error(InteractorError.invalidParams)
		}

		return execute()
	}

	public func execute() -> Observable<InteractorOutput> {
		fatalError("this has to be overriden")
	}

	public func validateParams() -> Bool {
		return false
	}
}

