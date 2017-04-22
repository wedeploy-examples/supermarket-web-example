//
//  ProductCart.swift
//  Supermarket-iOS
//
//  Created by Victor Galán on 22/04/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import Foundation

class ProductCart {
	let id: String
	let productId: String
	let userId: String
	let imageUrl: String
	let name: String
	let price: Float
	var ids: [String]

	init?(json: [String: AnyObject]) {
		guard let id = json["id"] as? String,
			let productId = json["productId"] as? String,
			let price = json["productPrice"] as? Float,
			let name = json["productTitle"] as? String,
			let imageUrl = json["productFilename"] as? String,
			let userId = json["userId"] as? String else { return nil }

		self.id = id
		self.productId = productId
		self.imageUrl = "http://public.easley84.wedeploy.io/assets/images/\(imageUrl)"
		self.name = name
		self.price = price
		self.userId = userId
		self.ids = [id]
	}
}

extension ProductCart : Equatable {

	public static func ==(lhs: ProductCart, rhs: ProductCart) -> Bool {
		return lhs.productId == rhs.productId
	}
}

extension ProductCart : Hashable {

	public var hashValue: Int {
		return "\(productId)\(price)\(name)\(imageUrl)".hashValue
	}
}

