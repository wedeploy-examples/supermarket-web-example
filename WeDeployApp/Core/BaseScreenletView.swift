//
//  BaseScreenletView.swift
//  WeDeployApp
//
//  Created by Victor Galán on 05/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import UIKit

public class BaseScreenletView : UIView {
	var actionPerformer: ActionPerformer?

	public func perform(actionName: String, params: [String: Any]) {
		actionPerformer?(actionName, params)
	}

	public func interactionStarted(actionName: String) {

	}

	public func interactionEnded(actionName: String, result: [String: Any]) {

	}

	public func interactionErrored(actionName: String, error: Error) {
		
	}
}
