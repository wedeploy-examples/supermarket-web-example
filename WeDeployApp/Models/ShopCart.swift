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

	fileprivate var products = [Product : Int]()

	public var productsArray: [(product: Product, quantity: Int)] {
		var array = [(product: Product, quantity: Int)]()

		for (key, value) in products {
			array.append((key, value))
		}

		return array
	}

	private init() { }

	func add(product: Product, quantity: Int = 1) {
		if let currentQuantity = products[product] {
			products[product] = currentQuantity + quantity
		}
		else {
			products[product] = quantity
		}
	}

	func remove(product: Product) {
		products.removeValue(forKey: product)
	}

	func update(product: Product, quantity: Int) {
		products[product] = quantity
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
