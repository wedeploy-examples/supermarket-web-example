//
//  Product.swift
//  WeDeployApp
//
//  Created by Victor Galán on 19/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import Foundation

public struct Product: JSONDecodable {
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

extension Product : Equatable {

	public static func ==(lhs: Product, rhs: Product) -> Bool {
		return lhs.id == rhs.id
	}
}

