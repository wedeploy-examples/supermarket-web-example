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


public class FloatingView : UIView {

	let marginTop = 35.0
	let marginSide = 20.0

	let errorColor = UIColor(248, 22, 22, 1)
	let errorIcon = String.error
	let successColor = UIColor(0, 212, 85, 1)
	let successIcon = String.success

	let logoView = UILabel()
	let closeButton = UIButton()
	let messageLabel = UILabel()

	init() {
		let screenFrame = UIScreen.main.bounds

		let width = Double(screenFrame.width - 40)
		let height = 100.0

		let frame = CGRect(x: 20.0, y: -100.0, width: width, height: height)

		super.init(frame: frame)

		initialize()
	}

	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	public override func layoutSubviews() {
		super.layoutSubviews()

		frame.size.height = messageLabel.frame.height + 40
		self.frame = frame
	}

	func initialize() {
		backgroundColor = .white
		layer.cornerRadius = 4
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOffset = CGSize(width: 0, height: 6);
		layer.shadowOpacity = 0.1;
		layer.shadowRadius = 10
		layer.masksToBounds = false

		configureLogoView()
		configureCloseButton()
		configureLabel()

		let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(FloatingView.panView(_:)))

		addGestureRecognizer(gestureRecognizer)
	}

	func configureLogoView() {
		addSubview(logoView)

		logoView.translatesAutoresizingMaskIntoConstraints = false

		logoView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		logoView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
		logoView.widthAnchor.constraint(equalToConstant: 24).isActive = true
		logoView.heightAnchor.constraint(equalToConstant: 24).isActive = true

		logoView.textAlignment = .center
		logoView.textColor = UIColor(248, 22, 22, 1)
	}

	func configureCloseButton() {
		addSubview(closeButton)

		closeButton.translatesAutoresizingMaskIntoConstraints = false

		closeButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		closeButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
		closeButton.widthAnchor.constraint(equalToConstant: 36).isActive = true
		closeButton.heightAnchor.constraint(equalToConstant: 36).isActive = true

		closeButton.titleLabel?.font = UIFont.iconFont12px(ofSize: 18)
		closeButton.setTitle(.close, for: .normal)
		closeButton.setTitleColor(.WeTextColor, for: .normal)

		closeButton.addTarget(self, action: #selector(FloatingView.hide), for: .touchUpInside)
	}

	func configureLabel() {
		addSubview(messageLabel)

		messageLabel.translatesAutoresizingMaskIntoConstraints = false

		messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		messageLabel.rightAnchor.constraint(equalTo: closeButton.leftAnchor, constant: 0).isActive = true
		messageLabel.leftAnchor.constraint(equalTo: logoView.rightAnchor, constant: 16).isActive = true

		messageLabel.textColor = .WeTextColor
		messageLabel.font = UIFont.semiboldWeFont(ofSize: 15)
		messageLabel.numberOfLines = 0
	}

	open func show(message: String, error: Bool) {
		messageLabel.text = message
        
		showIcon(error: error)
		animateY(finalY: 35)
	}

	func showIcon(error: Bool) {
		if error {
			logoView.font = UIFont.iconFont12px(ofSize: 20)
			logoView.textColor = errorColor
			logoView.text = errorIcon
			logoView.backgroundColor = .white
		}
		else {
			logoView.layer.cornerRadius = 12
			logoView.layer.masksToBounds = true
			logoView.backgroundColor = successColor
			logoView.font = UIFont.iconFont12px(ofSize: 12)
			logoView.text = successIcon
			logoView.textColor = .white
		}
	}

	open func hide() {
		animateY(finalY: -100)
	}

	func animateY(finalY: CGFloat) {
		var newFrame = self.frame
		newFrame.origin.y = finalY

		UIView.animate(
			withDuration: 1,
			delay: 0,
			usingSpringWithDamping: 0.5,
			initialSpringVelocity: 10,
			options: [],
			animations: {
				self.frame = newFrame
			},
			completion: nil)
	}

	func panView(_ gestureRecognizer: UIPanGestureRecognizer) {
		if gestureRecognizer.state == .ended && self.frame.minX != 20 {
			UIView.animate(withDuration: 0.3, animations: {
				var newFrame = self.frame
				newFrame.origin.x = UIScreen.main.bounds.maxX + 10
				self.frame = newFrame
			}, completion: { _ in
				self.frame = CGRect(x: 20.0,
						y: -100,
						width: self.frame.width,
						height: self.frame.height)
			})
		}

		let view = gestureRecognizer.view!

		if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
			let translation = gestureRecognizer.translation(in: view.superview)

			view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y)
			gestureRecognizer.setTranslation(CGPoint.zero, in: view.superview)
		}
	}

	func adjustAnchorPoint(for gestureRecognizer: UIGestureRecognizer) {
		let view = gestureRecognizer.view!

		let locationInView = gestureRecognizer.location(in: view)
		let locationInSuperView = gestureRecognizer.location(in: view.superview)

		view.layer.anchorPoint = CGPoint(x: locationInView.x / view.bounds.width, y: locationInView.y / view.bounds.height)
		view.center = locationInSuperView
	}
}


