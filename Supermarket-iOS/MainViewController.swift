/**
* Copyright (c) 2000-present Liferay, Inc. All rights reserved.
*
* This library is free software; you can redistribute it and/or modify it under
* the terms of the GNU Lesser General Public License as published by the Free
* Software Foundation; either version 2.1 of the License, or (at your option)
* any later version.
*
* This library is distributed in the hope that it will be useful, but WITHOUT
* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
* FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
* details.
*/


import UIKit
import WZLBadge
import Kingfisher

class MainViewController: UIViewController, UICollectionViewDataSource,
		UICollectionViewDelegateFlowLayout {

	@IBOutlet weak var categoryView: ViewWithArrow!
	@IBOutlet weak var spinner: UIActivityIndicatorView!
	@IBOutlet weak var toolbarView: UIView!
	@IBOutlet weak var navigationBar: UINavigationBar!
	@IBOutlet weak var changeLayoutButton: UIButton!
	@IBOutlet weak var cartIcon: UIButton!
	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var topConstraint: NSLayoutConstraint!
	@IBOutlet weak var profileImage: UIImageView!

	var previousOffset: CGFloat = 0
	var itemWidth: CGFloat = 0
	var itemHeight: CGFloat = 320
	var isAnimatingAddToCart = false
	var totalItemsInCart: Int = 0
	
	var currentLayout: LayoutType = .card

	public lazy var animationImageView: UIImageView = {
		let i = UIImageView()
		i.contentMode = .scaleAspectFill
		i.clipsToBounds = true
		i.layer.cornerRadius = 4

		return i
	}()
	
	let weDeployClient = WeDeployAPIClient()
	var items = [Product]()

	override func viewDidLoad() {
		super.viewDidLoad()

		customizeViews()

		collectionView.dataSource = self
		collectionView.delegate = self

		let nib = UINib(nibName: "ProductCell", bundle: nil)
		self.collectionView.register(nib, forCellWithReuseIdentifier: "cell")

		loadDataFrom(category: "all")

		if let url = Settings.shared.user?.photoUrl {
			profileImage.kf.setImage(with: URL(string: url)!)
		}
	}

	func loadDataFrom(category: String) {
		items = []
		collectionView.reloadData()

		spinner.startAnimating()

		weDeployClient.loadProducts(category: category.lowercased()) { objects, error in
			self.spinner.stopAnimating()
			if let objects = objects {
				self.items = objects
				self.collectionView.reloadData()
			}
		}
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return items.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
			-> UICollectionViewCell {

		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
		configureCell(cell: cell, item: items[indexPath.row])
		return cell
	}

	open func configureCell(cell: UICollectionViewCell, item: Product) {
		let cell = cell as! ProductCell

		cell.imageUrl = item.imageUrl
		cell.nameLabel.text = item.name
		cell.priceLabel.text = "$\(item.price)"

		cell.onAddToCartClick = { [unowned self] in
			guard !self.isAnimatingAddToCart else { return }

			self.isAnimatingAddToCart = true
			self.totalItemsInCart += 1

			let indexPath = self.collectionView.indexPath(for: cell)

			let attributes = self.collectionView.layoutAttributesForItem(at: indexPath!)
			let cellFrame = self.collectionView.convert(attributes!.frame, to: self.view)
			let pictureFrame = cell.productImage.frame

			var finalFrame = cellFrame
			finalFrame.origin.x += pictureFrame.minX
			finalFrame.origin.y += pictureFrame.minY
			finalFrame.size = pictureFrame.size

			self.animationImageView.frame = finalFrame
			self.animationImageView.image = cell.productImage.image
			self.animationImageView.backgroundColor = .white

			self.animateAddToCart()
		}
	}

	@IBAction func changeLayoutButtonClick() {
		let nextType = self.currentLayout.nextLayout

		if case .collection = nextType {
			self.itemWidth = self.view.frame.width/2
		}
		else {
			self.itemWidth = self.view.frame.width
		}

		self.itemHeight = nextType.height
		self.changeLayoutButton.setTitle(nextType.nextLayout.icon, for: .normal)

		self.currentLayout = nextType

		self.collectionView.performBatchUpdates({
			self.collectionView.collectionViewLayout.invalidateLayout()
		}, completion: nil)
	}

	func customizeViews() {
		changeLayoutButton.backgroundColor = .WeTextFieldSelectedBackgroundColor
		changeLayoutButton.setTitleColor(.WeTextColor, for: .normal)
		changeLayoutButton.layer.cornerRadius = 4
		changeLayoutButton.setTitle(currentLayout.nextLayout.icon, for: .normal)

		cartIcon.setTitleColor(.white, for: .normal)
		cartIcon.setTitle(.cart, for: .normal)

		navigationBar.titleTextAttributes = [
			NSForegroundColorAttributeName : UIColor.white,
			NSFontAttributeName: UIFont.boldSystemFont(ofSize: 20)
		]
		navigationBar.topItem?.title = "Supermarket"
		navigationBar.barTintColor = .mainColor

		toolbarView.addWeDeployShadow()

		spinner.color = .mainColor
		spinner.hidesWhenStopped = true

		categoryView.onClick = { [weak self] in
			self?.categoryButtonClick()
		}

		collectionView.backgroundColor = .white

		itemWidth = view.frame.width

		view.addSubview(animationImageView)

		self.profileImage.layer.cornerRadius = self.profileImage.frame.width/2
		self.profileImage.layer.masksToBounds = true

		let tap = UITapGestureRecognizer(target: self, action: #selector(profileImageClick))
		self.profileImage.addGestureRecognizer(tap)
	}

	func categoryButtonClick() {
		let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

		let handler = { [weak self] (alertView: UIAlertAction) -> Void in
			self?.loadDataFrom(category: alertView.title ?? "All")
			self?.categoryView.text = alertView.title
		}

		let allAction = UIAlertAction(title: "All", style: .default, handler: handler)
		let bakeryAction = UIAlertAction(title: "Bakery", style: .default, handler: handler)
		let dairyAction = UIAlertAction(title: "Dairy", style: .default, handler: handler)
		let fruitAction = UIAlertAction(title: "Fruit", style: .default, handler: handler)
		let vegetableAction = UIAlertAction(title: "Vegetable", style: .default, handler: handler)
		let meatAction = UIAlertAction(title: "Meat", style: .default, handler: handler)

		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

		alertController.addAction(allAction)
		alertController.addAction(bakeryAction)
		alertController.addAction(dairyAction)
		alertController.addAction(fruitAction)
		alertController.addAction(vegetableAction)
		alertController.addAction(meatAction)
		alertController.addAction(cancelAction)

		present(alertController, animated: true, completion: nil)
	}

	func animateAddToCart() {
		UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 30, options: [], animations: {

			self.animationImageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
		}, completion:nil)

		UIView.animate(withDuration: 0.3, delay: 0.3, options: [], animations: {
			self.animationImageView.frame = CGRect(x: 25, y: 25, width: 25, height: 25)
			self.animationImageView.alpha = 0.1
		}, completion: { _ in
			self.animationImageView.transform = CGAffineTransform.identity
			self.animationImageView.frame = CGRect.zero
			self.animationImageView.alpha = 1
		})

		UIView.animate(withDuration: 0.2, delay: 0.4, options: [], animations: {
			self.cartIcon.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
		}, completion: { _ in
			self.cartIcon.showBadge(with: .number, value: self.totalItemsInCart, animationType: .none)
		})

		UIView.animate(withDuration: 0.1, delay: 0.6, options: [], animations: {
			self.cartIcon.transform = CGAffineTransform.identity
		}, completion: { _ in
			self.isAnimatingAddToCart = false
		})
		
	}

	func profileImageClick() {
		let logoutAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

		let logoutAction = UIAlertAction(title: "Log out", style: .destructive) { [weak self] _ in
			self?.navigationController?.popViewController(animated: true)
		}

		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

		logoutAlert.addAction(logoutAction)
		logoutAlert.addAction(cancelAction)


		present(logoutAlert, animated: true, completion: nil)
	}

	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let size = self.toolbarView.frame.height
		let scrollOffset = scrollView.contentOffset.y
		let scrollDiff = scrollOffset - self.previousOffset
		let scrollHeight = scrollView.frame.height
		let scrollcontentSizeHeight = scrollView.contentSize.height + scrollView.contentInset.bottom

		if scrollOffset <= -scrollView.contentInset.top {
			topConstraint.constant = 0
		} else if scrollOffset + scrollHeight >= scrollcontentSizeHeight {
			topConstraint.constant = -size
		} else {
			topConstraint.constant = min(0, max(-size, topConstraint.constant - scrollDiff))
		}

		self.previousOffset = scrollOffset
	}

	func collectionView(_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

		return 0
	}

	func collectionView(_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath) -> CGSize {

		return CGSize(width: itemWidth, height: itemHeight)
	}

	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
}
