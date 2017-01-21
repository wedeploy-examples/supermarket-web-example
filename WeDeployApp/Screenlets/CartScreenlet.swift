//
//  File.swift
//  WeDeployApp
//
//  Created by Victor Galán on 20/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import Foundation
import RxSwift

public enum CartScreenletDelegate {
	case actionStarted
}


open class CartScreenlet : BaseScreenlet {

	public var delegate = PublishSubject<DataListScreenletDelegate>()

	open override func interactionStarted(actionName: String) {
		super.interactionStarted(actionName: actionName)

		delegate.onNext(.actionStarted(actionName))
	}

}
