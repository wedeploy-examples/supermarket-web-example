//
//  MainViewController.swift
//  WeDeployApp
//
//  Created by Victor Galán on 16/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import UIKit

public class MainViewController : UIViewController {


	@IBAction func backButtonClick() {
		_ = navigationController?.popViewController(animated: true)
	}
	
}
