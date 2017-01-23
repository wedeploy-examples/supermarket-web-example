//
//  IntialViewController.swift
//  WeDeployApp
//
//  Created by Victor Galán on 12/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import UIKit


public class InitalViewConroller : UIViewController {

	@IBOutlet weak var logoLabel: UILabel!

	public var goLogin = false
	public var goSingUp = false

	public override func viewDidLoad() {

		logoLabel.text = .thunder
		logoLabel.layer.cornerRadius = 42
		logoLabel.backgroundColor = .white
		logoLabel.layer.masksToBounds = true
		logoLabel.textColor = .mainColor

		view.backgroundColor = .mainColor
		setNeedsStatusBarAppearanceUpdate()
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
}
