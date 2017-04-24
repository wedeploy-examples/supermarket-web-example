//
//  CartItemCell.swift
//  WeDeployApp
//
//  Created by Victor Galán on 20/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import UIKit

class CartItemCell: UICollectionViewCell {
	
	@IBOutlet weak var shadowView: UIView! {
		didSet {
			shadowView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
			shadowView.layer.shadowOffset = CGSize(width: 0, height: 2);
			shadowView.layer.shadowRadius = 8;
			shadowView.layer.shadowOpacity = 1;
			shadowView.layer.masksToBounds = false
			shadowView.layer.cornerRadius = 4
		}
	}


	@IBOutlet weak var productImage: UIImageView! {
		didSet {
			productImage.layer.cornerRadius = 4
		}
	}

	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var stepper: Stepper!
	@IBOutlet weak var priceLabel: UILabel!

	public var onAdd: ((Int) -> Void)? {
		didSet {
			stepper.onAdd = onAdd
		}
	}

	public var onDecrement: ((Int) -> Void)? {
		didSet {
			stepper.onDecrement = onDecrement
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
