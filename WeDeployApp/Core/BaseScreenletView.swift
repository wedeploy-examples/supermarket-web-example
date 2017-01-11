//
//  BaseScreenletView.swift
//  WeDeployApp
//
//  Created by Victor Galán on 05/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import UIKit

open class BaseScreenletView : UIView {
	var actionPerformer: ActionPerformer?

	open func perform(actionName: String, params: InteractorInput) {
		actionPerformer?(actionName, params)
	}

	open func interactionStarted(actionName: String) {

	}

	open func interactionEnded(actionName: String, result: InteractorOutput) {

	}

	open func interactionErrored(actionName: String, error: Error) {
		
	}
}
