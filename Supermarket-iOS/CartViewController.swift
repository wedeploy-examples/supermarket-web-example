//
//  CartViewController.swift
//  Supermarket-iOS
//
//  Created by Victor Galán on 21/04/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, UICollectionViewDataSource {

	@IBOutlet weak var cartLabel: UILabel!
	@IBOutlet weak var cartView: UIView!
	@IBOutlet weak var checkoutButton: UIButton!
	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var emptyCartView: UIView!

	var products: [ProductCart] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        customizeViews()
		fillCart()
	}

	func customizeViews() {
		cartView.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
		cartView.layer.shadowOffset = CGSize(width: 0, height: 7);
		cartView.layer.shadowRadius = 12;
		cartView.layer.shadowOpacity = 1;
		cartView.layer.masksToBounds = false
		cartView.layer.cornerRadius = cartView.frame.width/2

		cartLabel.text = .cart

		collectionView.dataSource = self
		collectionView.register(UINib(nibName: "CartItemCell", bundle: nil), forCellWithReuseIdentifier: "cell")
		(collectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize =
			CGSize(width: self.view.frame.width, height: 132)
		collectionView.alwaysBounceVertical = true

		emptyCartView.isHidden = true
	}

	func fillCart() {
		WeDeployAPIClient().loadCartProducts { cartProducts, error in
			guard let cartProducts = cartProducts else { return }

			self.products = cartProducts
			if self.products.isEmpty {
				self.emptyCartView.isHidden = false
			}
			self.collectionView.reloadData()
		}
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return products.count
	}

	func collectionView(_ collectionView: UICollectionView,
		cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView
			.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CartItemCell else {
				return UICollectionViewCell()
		}

		let product = products[indexPath.row]
		cell.imageUrl = product.imageUrl
		cell.nameLabel.text = product.name
		cell.priceLabel.text = "\(product.price)"
		cell.stepper.currentValue = product.ids.count

		return cell
	}

	@IBAction func checkoutButtonClick(_ sender: Any) {
		if products.isEmpty {
			self.dismiss(animated: true, completion: nil)
		}
		else {
			weDeployClient.sendCheckoutEmail(products: products)
		}
	}

}
