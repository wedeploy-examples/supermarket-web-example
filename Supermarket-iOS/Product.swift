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


import Foundation

public struct Product {
	let id: String
	let price: Float
	let name: String
	let imageUrl: String

	public init(json: [String: AnyObject]) {
		self.id = json["id"] as! String
		self.price = json["price"] as! Float
		self.name = json["title"] as! String
		self.imageUrl = "http://public.easley84.wedeploy.io/assets/images/" + (json["filename"] as! String)
	}
}

