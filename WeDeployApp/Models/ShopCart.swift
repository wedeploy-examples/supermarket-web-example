//
//  ShopCart.swift
//  WeDeployApp
//
//  Created by Victor Galán on 19/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import Foundation

public class ShopCart: CustomStringConvertible {

	public static let shared = ShopCart()

	public var products = [String : Int]()

	private init() { }

	func add(product: Product, quantity: Int = 1) {
		if let currentQuantity = products[product.id] {
			products[product.id] = currentQuantity + quantity
		}
		else {
			products[product.id] = quantity
		}
	}

	func remove(product: Product, quantity: Int = 1) {
		
	}

	public func emptyCart() {
		products = [:]
	}

	public var description: String {
		return products.description
	}

	public var totalItemsCount: Int {
		return products.reduce(0, { (sum, entry) -> Int in
			return sum + entry.value
		})
	}
}
