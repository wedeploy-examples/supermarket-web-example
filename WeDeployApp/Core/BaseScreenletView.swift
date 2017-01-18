//
//  BaseScreenletView.swift
//  WeDeployApp
//
//  Created by Victor Galán on 05/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import UIKit

extension String : InteractorInput { }

open class BaseScreenletView : UIView {
	var actionPerformer: ActionPerformer?


	open func perform(actionName: String, params: InteractorInput, requiresInteractor: Bool = true) {
		actionPerformer?(actionName, params, requiresInteractor)
	}

	open func perform(actionName: String) {
		actionPerformer?(actionName, "no params", false)
	}

	open func interactionStarted(actionName: String) {

	}

	open func interactionEnded(actionName: String, result: InteractorOutput) {

	}

	open func interactionErrored(actionName: String, error: Error) {
		
	}
}
