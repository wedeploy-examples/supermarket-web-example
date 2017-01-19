//
//  DataListScreenleet.swift
//  WeDeployApp
//
//  Created by Victor Galán on 16/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import UIKit
import RxSwift

public enum DataListScreenletDelegate {
	case actionStarted(String)
}

open class DataListScreenlet : BaseScreenlet {
	public static let LoadDataAction = "LoadData"

	public var delegate = PublishSubject<DataListScreenletDelegate>()

	open override func interactionStarted(actionName: String) {
		super.interactionStarted(actionName: actionName)

		delegate.onNext(.actionStarted(actionName))
	}


}
