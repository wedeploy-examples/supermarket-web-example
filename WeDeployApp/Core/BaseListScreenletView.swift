//
//  BaseListScreenletView.swift
//  WeDeployApp
//
//  Created by Victor Galán on 17/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import UIKit

open class BaseListScreenletView: BaseScreenletView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

	@IBOutlet weak var collectionView: UICollectionView!
	public var items: [Any] = []

	open var itemSize: CGSize {
		return CGSize.zero
	}

	open override func onCreated() {
		self.collectionView.dataSource = self
		self.collectionView.delegate = self
		self.collectionView.alwaysBounceVertical = true

		self.registerCell(with: "cell")
	}

	open override func interactionEnded(actionName: String, result: InteractorOutput) {
		if let result = result as? [Any] {
			items = result
		}
		collectionView.reloadData()
	}

	open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return items.count
	}

	open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductCell

		configureCell(cell: cell, item: items[indexPath.row])

		return cell
	}

	open func itemFor<T>(index: Int, type: T.Type = T.self) -> T {
		return items[index] as! T
	}

	open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		if itemSize == CGSize.zero {
			return CGSize(width: self.frame.width, height: 80)
		}

		return itemSize
	}

	open func registerCell(with identifier: String) {

	}

	open func configureCell(cell: UICollectionViewCell, item: Any) {
		
	}
	
}
