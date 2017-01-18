//
//  ProductCell.swift
//  WeDeployApp
//
//  Created by Victor Galán on 16/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import UIKit
import Kingfisher

class ProductCell: UICollectionViewCell {

	@IBOutlet weak var nameLabel: UILabel!

	@IBOutlet weak var priceLabel: UILabel! 
	
	@IBOutlet weak var shadowView: UIView! {
		didSet {
			shadowView.layer.shadowColor = UIColor.black.cgColor
			shadowView.layer.shadowOffset = CGSize(width: 0, height: 0);
			shadowView.layer.shadowRadius = 5;
			shadowView.layer.shadowOpacity = 0.3;
			shadowView.layer.masksToBounds = false
			shadowView.layer.cornerRadius = 4
		}
	}

	@IBOutlet private weak var productImage: UIImageView! {
		didSet {
			productImage.layer.cornerRadius = 4
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

    override func awakeFromNib() {
        super.awakeFromNib()

		productImage.clipsToBounds = true
	}

}
