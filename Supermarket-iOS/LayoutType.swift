/**
* Copyright (c) 2000-present Liferay, Inc. All rights reserved.
*
* This library is free software; you can redistribute it and/or modify it under
* the terms of the GNU Lesser General Public License as published by the Free
* Software Foundation; either version 2.1 of the License, or (at your option)
* any later version.
*
* This library is distributed in the hope that it will be useful, but WITHOUT
* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
* FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
* details.
*/


import UIKit

public enum LayoutType {
	case card
	case list
	case collection

	var icon: String  {
		switch self {
		case .card:
			return .cardLayout
		case .list:
			return .listLayout
		case .collection:
			return .collectionLayout
		}
	}

	var nextLayout: LayoutType {
		switch self {
		case .card:
			return .list
		case .list:
			return .collection
		case .collection:
			return .card
		}
	}

	var height: CGFloat {
		switch self {
		case .card:
			return 320
		case .list:
			return 132
		case .collection:
			return 252
		}
	}
}
