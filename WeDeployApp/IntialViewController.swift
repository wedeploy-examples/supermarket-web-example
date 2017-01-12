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

	public override func viewDidLoad() {

		logoLabel.text = "\u{E55F}"
		logoLabel.layer.cornerRadius = 42
		logoLabel.backgroundColor = .white
		logoLabel.layer.masksToBounds = true
		logoLabel.textColor = .mainColor

		view.backgroundColor = .mainColor
	}

	@IBAction func goToLoginClick() {
		performSegue(withIdentifier: "login", sender: nil)
	}
}
