//
//  UserPortraitScreenlet.swift
//  WeDeployApp
//
//  Created by Victor Galán on 18/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import UIKit

open class UserPortraitScreenlet : BaseScreenlet {
	public static let GetCurrentUserAction = "GetCurrentUserAction"


	open override func awakeFromNib() {
		super.awakeFromNib()
		backgroundColor = .clear
	}
}
