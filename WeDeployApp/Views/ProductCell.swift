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

	var const: [NSLayoutConstraint] = []

	var lastFrameHeight: CGFloat = 0
	var isFirstStart = true

	@IBOutlet weak var nameLabel: UILabel! {
		didSet {
			nameLabel.translatesAutoresizingMaskIntoConstraints = false
		}
	}

	@IBOutlet weak var priceLabel: UILabel! {
		didSet {
			priceLabel.translatesAutoresizingMaskIntoConstraints = false
		}
	}
	
	@IBOutlet weak var addToCartButton: WeColorButton! {
		didSet {
			addToCartButton.translatesAutoresizingMaskIntoConstraints = false
		}
	}

	@IBOutlet weak var shadowView: UIView! {
		didSet {
			shadowView.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
			shadowView.layer.shadowOffset = CGSize(width: 0, height: 2);
			shadowView.layer.shadowRadius = 8;
			shadowView.layer.shadowOpacity = 1;
			shadowView.layer.masksToBounds = false
			shadowView.layer.cornerRadius = 4

			shadowView.translatesAutoresizingMaskIntoConstraints = false
		}
	}

	@IBOutlet weak var productImage: UIImageView! {
		didSet {
			productImage.layer.cornerRadius = 4
			productImage.clipsToBounds = true

			productImage.translatesAutoresizingMaskIntoConstraints = false
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

	public var onAddToCartClick: ((Void) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()

		addConstraintsForCartButton()
		addConstraintsForNameLabel()
		addConstraintsForPriceLabel()
		addConstraintsForProductImage()
		addConstraintsForShadowView()

	}

	@IBAction func addToCartClick() {
		onAddToCartClick?()
	}


	func addConstraintsForCartButton() {
		let const1 = addToCartButton.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 24)
		let const2 = addToCartButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20)
		let const3 = addToCartButton.widthAnchor.constraint(equalToConstant: 111)
		let const4 = addToCartButton.heightAnchor.constraint(equalToConstant: 36)

		addAndActivate(constraints: const1, const2, const3, const4)
	}

	func addConstraintsForPriceLabel() {
		let const1 = priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2)
		let const2 = priceLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20)
		let const3 = priceLabel.rightAnchor.constraint(equalTo: addToCartButton.leftAnchor, constant: -10)
		let const4 = priceLabel.heightAnchor.constraint(equalToConstant: 21)

		addAndActivate(constraints: const1, const2, const3, const4)
	}

	func addConstraintsForNameLabel() {
		let const1 = nameLabel.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 19)
		let const2 = nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20)
		let const3 = nameLabel.rightAnchor.constraint(equalTo: addToCartButton.leftAnchor, constant: -10)
		let const4 = nameLabel.heightAnchor.constraint(equalToConstant: 21)

		addAndActivate(constraints: const1, const2, const3, const4)
	}

	func addConstraintsForProductImage() {
		let const1 = productImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 20)
		let const2 = productImage.topAnchor.constraint(equalTo: topAnchor, constant: 10)
		let const3 = productImage.rightAnchor.constraint(equalTo: rightAnchor, constant: -20)
		let const4 = productImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7)

		addAndActivate(constraints: const1, const2, const3, const4)
	}

	func addConstraintsForShadowView() {
		let const1 = shadowView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20)
		let const2 = shadowView.topAnchor.constraint(equalTo: topAnchor, constant: 10)
		let const3 = shadowView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20)
		let const4 = shadowView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7)

		addAndActivate(constraints: const1, const2, const3, const4)
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		if lastFrameHeight != frame.height {
			lastFrameHeight = frame.height

			if lastFrameHeight == WeDataListScreenletView.LayoutType.list.height {
				productImage.layer.cornerRadius = 4
				productImage.layer.mask = nil

				self.const.forEach {$0.isActive = false}
				self.const.removeAll()

				let const1 = productImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 20)
				let const2 = productImage.topAnchor.constraint(equalTo: topAnchor, constant: 5) 
				let const3 = productImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5) 
				let const4 = productImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4) 

				let const5 = shadowView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20) 
				let const6 = shadowView.topAnchor.constraint(equalTo: topAnchor, constant: 5) 
				let const7 = shadowView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5) 
				let const8 = shadowView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4) 

				let const9 = addToCartButton.leftAnchor.constraint(equalTo: productImage.rightAnchor, constant: 20) 
				let const10 = addToCartButton.widthAnchor.constraint(equalToConstant: 111) 
				let const11 = addToCartButton.heightAnchor.constraint(equalToConstant: 36) 
				let const12 = addToCartButton.bottomAnchor.constraint(equalTo: productImage.bottomAnchor, constant: -12) 

				let const13 = nameLabel.topAnchor.constraint(equalTo: productImage.topAnchor) 
				let const14 = nameLabel.leftAnchor.constraint(equalTo: productImage.rightAnchor, constant: 20) 
				let const15 = nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20) 

				let const16 = priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2) 
				let const17 = priceLabel.leftAnchor.constraint(equalTo: productImage.rightAnchor, constant: 20) 
				let const18 = priceLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20) 
				let const19 = priceLabel.heightAnchor.constraint(equalToConstant: 21) 

				nameLabel.numberOfLines = 2
				
				addAndActivate(constraints: const1, const2, const3, const4, const5, const6, const7, const8, const9, const10,
						const11, const12, const13, const14, const15, const16, const17, const18, const19)
				UIView.animate(withDuration: 0.3) {
					self.layoutIfNeeded()
				}
			}

			else if lastFrameHeight == WeDataListScreenletView.LayoutType.collection.height {
				self.const.forEach {$0.isActive = false}
				self.const.removeAll()

				let const1 = productImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 10)
				let const2 = productImage.topAnchor.constraint(equalTo: topAnchor, constant: 12)
				let const3 = productImage.rightAnchor.constraint(equalTo: rightAnchor, constant: -10)
				let const4 = productImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4)

				let const5 = shadowView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10)
				let const6 = shadowView.topAnchor.constraint(equalTo: topAnchor, constant: 12)
				let const7 = shadowView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10)
				let const8 = shadowView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)

				let const10 = addToCartButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 22)
				let const9 = addToCartButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -22)
				let const11 = addToCartButton.heightAnchor.constraint(equalToConstant: 36)
				let const12 = addToCartButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -22)

				let const13 = nameLabel.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 6)
				let const14 = nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 22)
				let const15 = nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -22)

				let const16 = priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2)
				let const17 = priceLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 22)
				let const18 = priceLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -22)
				let const19 = priceLabel.heightAnchor.constraint(equalToConstant: 21)

				nameLabel.numberOfLines = 2
				addAndActivate(constraints: const1, const2, const3, const4, const5, const6, const7, const8, const9, const10,
				               const11, const12, const13, const14, const15, const16, const17, const18, const19)


				UIView.animate(withDuration: 0.3, animations: {
					self.layoutIfNeeded()
				}, completion: { _ in
					self.productImage.layer.cornerRadius = 0
					let path = UIBezierPath(
						roundedRect: self.productImage.bounds,
						byRoundingCorners: [.topLeft, .topRight],
						cornerRadii: CGSize(width: 4, height: 4))

					let mask = CAShapeLayer()
					mask.path = path.cgPath
					self.productImage.layer.mask = mask
				})
			}
			else {
				productImage.layer.mask = nil
				productImage.layer.cornerRadius = 4

				self.const.forEach {$0.isActive = false}
				self.const.removeAll()

				nameLabel.numberOfLines = 1
				addConstraintsForCartButton()
				addConstraintsForNameLabel()
				addConstraintsForPriceLabel()
				addConstraintsForProductImage()
				addConstraintsForShadowView()

				if isFirstStart {
					isFirstStart = false
					return
				}

				UIView.animate(withDuration: 0.3) {
					self.layoutIfNeeded()
				}
			}
		}

	}

	public func addAndActivate(constraints: NSLayoutConstraint...) {
		constraints.forEach { $0.isActive = true }
		self.const.append(contentsOf: constraints)
	}

}
