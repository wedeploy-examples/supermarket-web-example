//
//  Stepper.swift
//  WeDeployApp
//
//  Created by Victor Galán on 19/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import UIKit

public class Stepper : UIView {

	let plusButton: UIButton = {
		let b = UIButton()
		b.translatesAutoresizingMaskIntoConstraints = false
		b.titleLabel?.font = UIFont.iconFont16px(ofSize: 15)
		b.setTitleColor(.mainColor, for: .normal)
		b.setTitle(.plus, for: .normal)
		b.addTarget(self, action: #selector(plusButtonClicked), for: .touchUpInside)

		return b
	}()

	let minusButton: UIButton = {
		let b = UIButton()
		b.translatesAutoresizingMaskIntoConstraints = false
		b.titleLabel?.font =  UIFont.iconFont16px(ofSize: 15)
		b.setTitleColor(.mainColor, for: .normal)
		b.setTitle(.minus, for: .normal)
		b.addTarget(self, action: #selector(minusButtonClicked), for: .touchUpInside)

		return b
	}()

	lazy var numberLabel: UILabel = {
		let b = UILabel()
		b.translatesAutoresizingMaskIntoConstraints = false
		b.font = UIFont.boldWeFont(ofSize: 14)
		b.textAlignment = .center
		b.textColor = .WeTextColor
		b.text = "0"

		return b
	}()

	public var currentValue: Int = 0 {
		didSet {
			currentValueChanged?(currentValue)
			numberLabel.text = "\(currentValue)"
		}
	}

	public var currentValueChanged: ((Int) -> Void)?

	override public init(frame: CGRect) {
		super.init(frame: frame)
		initialize()
	}

	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		initialize()
	}

	func initialize() {
		layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
		layer.shadowOffset = CGSize(width: 0, height: 2);
		layer.shadowRadius = 8;
		layer.shadowOpacity = 1;
		layer.masksToBounds = false
		layer.cornerRadius = 4

		addSubview(numberLabel)
		addSubview(plusButton)
		addSubview(minusButton)

		minusButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
		minusButton.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		minusButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		minusButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 2/7).isActive = true

		plusButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
		plusButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		plusButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		plusButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 2/7).isActive = true

		numberLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
		numberLabel.leftAnchor.constraint(equalTo: minusButton.rightAnchor).isActive = true
		numberLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		numberLabel.rightAnchor.constraint(equalTo: plusButton.leftAnchor).isActive = true
	}

	func plusButtonClicked() {
		currentValue += 1
	}

	func minusButtonClicked() {
		if currentValue > 0 {
			currentValue -= 1
		}
	}
}
