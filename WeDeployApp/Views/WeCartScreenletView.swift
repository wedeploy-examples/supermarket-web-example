//
//  WeCartScreenletView.swift
//  WeDeployApp
//
//  Created by Victor Galán on 20/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import UIKit

class WeCartScreenletView: BaseListScreenletView {

	public static let CloseCartAction = "CloseCartAction"
	public static let SendCheckoutEmailAction = "SendCheckoutEmailAction"

	override var itemSize: CGSize {
		return CGSize(width: self.frame.width, height: 132)
	}

	@IBOutlet weak var cartLabel: UILabel! {
		didSet {
			cartLabel.text = .cart
		}
	}
	
	@IBOutlet weak var cartView: UIView! {
		didSet {
			cartView.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
			cartView.layer.shadowOffset = CGSize(width: 0, height: 7);
			cartView.layer.shadowRadius = 12;
			cartView.layer.shadowOpacity = 1;
			cartView.layer.masksToBounds = false
			cartView.layer.cornerRadius = cartView.frame.width/2
		}
	}

	@IBOutlet weak var emptyCartView: UIView!

	@IBOutlet weak var checkoutButton: WeColorButton!

	var floatingView = FloatingView()
	
	override func onCreated() {
		super.onCreated()

		self.items = ShopCart.shared.productsArray

		superview?.superview?.addSubview(floatingView)

		if items.count > 0 {
			emptyCartView.alpha = 0
			updateTitle()
		}
	}

	override func registerCell(with identifier: String) {
		let nib = UINib(nibName: "CartItemCell", bundle: nil)

		collectionView.register(nib, forCellWithReuseIdentifier: identifier)
	}

	override func configureCell(cell: UICollectionViewCell, item: Any) {
		let cell = cell as! CartItemCell
		let item = item as! (product: Product, quantity: Int)

		cell.imageUrl = item.product.imageUrl
		cell.nameLabel.text = item.product.name
		cell.priceLabel.text = "$\(item.product.price)"
		cell.stepper.currentValue = item.quantity

		cell.itemQuantityChanged = {[unowned self] newQuantity in
			let indexPath = self.collectionView.indexPath(for: cell)!

			if newQuantity == 0 {
				self.collectionView.performBatchUpdates({
					self.items.remove(at: indexPath.row)
					self.collectionView.deleteItems(at: [indexPath])
				}, completion: nil)

				ShopCart.shared.remove(product: item.product)

				if self.items.count == 0 {
					UIView.animate(withDuration: 0.5) {
						self.emptyCartView.alpha = 1
					}
				}
			}
			else {
				self.items[indexPath.row] = (item.product, newQuantity)
				ShopCart.shared.update(product: item.product, quantity: newQuantity)
			}

			self.updateTitle()
		}
	}

	func updateTitle() {
		let items = self.items as! [(product: Product, quantity: Int)]

		if items.count == 0 {
			checkoutButton.setTitle("Start shopping", for: .normal)
		}
		else {
			let totalAmount = items.reduce(0) { (sum, productTuple) in
				sum + productTuple.product.price * Float(productTuple.quantity)
			}

			checkoutButton.setTitle("Checkout: $\(totalAmount)", for: .normal)
		}
	}

	@IBAction func checkoutButtonClick(_ sender: Any) {
		if items.count == 0 {
			perform(actionName: WeCartScreenletView.CloseCartAction)
		}
		else {
			let subject = "Your order"
			var body = ""

			for item in items {
				let item = item as! (product: Product, quantity: Int)
				body = "- \(item.product.name) x \(item.quantity)\n"
			}

			body += checkoutButton.titleLabel!.text!

			let input = SendEmailInteractorInput(subject: subject, body: body)

			perform(actionName: WeCartScreenletView.SendCheckoutEmailAction, params: input)
		}
	}

	override func interactionEnded(actionName: String, result: InteractorOutput) {
		if actionName == WeCartScreenletView.SendCheckoutEmailAction {
			floatingView.show(message: "Email sent with the details of the order", error: false)
		}
	}

	override func interactionErrored(actionName: String, error: Error) {
		if actionName == WeCartScreenletView.SendCheckoutEmailAction {
			floatingView.show(message: "Error sending email", error: true)
		}
	}
}
