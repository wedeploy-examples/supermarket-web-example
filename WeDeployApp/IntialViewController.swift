//
//  IntialViewController.swift
//  WeDeployApp
//
//  Created by Victor Galán on 12/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import UIKit


public class InitalViewConroller : UIViewController, UIGestureRecognizerDelegate {

	@IBOutlet weak var logoLabel: UILabel!
	@IBOutlet weak var colorButton: WeColorButton!

	public var goLogin = false
	public var goSingUp = false

	let mainColors = [
		UIColor(8, 223, 133, 1),
		UIColor(0, 164, 255, 1),
		UIColor(149, 82, 239, 1),
		UIColor(255, 64, 64, 1),
		UIColor(255, 11, 110, 1),
		UIColor(255, 183, 0, 1)
	]

	var index = 0

	public override func viewDidLoad() {

		logoLabel.text = .thunder
		logoLabel.layer.cornerRadius = 42
		logoLabel.backgroundColor = .white
		logoLabel.layer.masksToBounds = true
		logoLabel.textColor = .mainColor

		view.backgroundColor = .mainColor
		setNeedsStatusBarAppearanceUpdate()

		let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
		tap.numberOfTapsRequired = 2
		tap.delegate = self
		
		view.addGestureRecognizer(tap)
	}

	public override func viewDidAppear(_ animated: Bool) {
		if goLogin {
			goLogin = false
			performSegue(withIdentifier: "login", sender: nil)
		}
		else if goSingUp {
			goSingUp = false
			performSegue(withIdentifier: "signup", sender: nil)
		}
	}

	public override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}

	func doubleTapped() {
		if index == mainColors.count - 1 {
			index = 0
		}
		index += 1

		UIColor.mainColor = mainColors[index]

		view.backgroundColor = .mainColor
		colorButton.setTitleColor(.mainColor, for: .normal)
		logoLabel.textColor = .mainColor
	}

	public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
		if let _ = touch.view as? UIButton {
			return false
		}

		return true
	}
}
