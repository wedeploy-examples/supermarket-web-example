//
//  CartItemCell.swift
//  WeDeployApp
//
//  Created by Victor Galán on 20/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import UIKit

class CartItemCell: UICollectionViewCell {
	
	@IBOutlet weak var productImage: UIImageView! {
		didSet {
			productImage.layer.cornerRadius = 4
		}
	}

	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var stepper: Stepper!
	@IBOutlet weak var priceLabel: UILabel!

	public var itemQuantityChanged: ((Int) -> Void)? {
		didSet {
			stepper.currentValueChanged = itemQuantityChanged
		}
	}

	public var imageUrl: String {
		set {
			self.productImage.kf.setImage(with: URL(string: newValue)!)
		}
		get {
			return ""
		}
	}

}
