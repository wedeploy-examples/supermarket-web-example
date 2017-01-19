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
		b.titleLabel?.font = UIFont(name: "loop-icons-16px", size: 15)
		b.setTitleColor(.mainColor, for: .normal)
		b.setTitle("\u{E50D}", for: .normal)

		return b
	}()

	let minusButton: UIButton = {
		let b = UIButton()
		b.translatesAutoresizingMaskIntoConstraints = false
		b.titleLabel?.font =  UIFont(name: "loop-icons-16px", size: 15)
		b.setTitleColor(.mainColor, for: .normal)
		b.setTitle("\u{E543}", for: .normal)

		return b
	}()

	lazy var numberLabel: UILabel = {
		let b = UILabel()
		b.translatesAutoresizingMaskIntoConstraints = false
		b.font = UIFont(name: "GalanoGrotesque-Bold", size: 14)
		b.textAlignment = .center
		b.textColor = .WeTextColor
		b.text = "0"

		return b
	}()

	public var currentValue: Int = 0 {
		didSet {
			numberLabel.text = "\(currentValue)"
		}
	}

	override public init(frame: CGRect) {
		super.init(frame: frame)
		initialize()
	}

	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		initialize()
	}

	func initialize() {
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOffset = CGSize(width: 0, height: 0);
		layer.shadowRadius = 5;
		layer.shadowOpacity = 0.1;
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
}
