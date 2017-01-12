//
//  ViewController.swift
//  WeDeployApp
//
//  Created by Victor Galán on 05/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import UIKit
import WeDeploy
import RxSwift
import RxCocoa


class LoginViewController: UIViewController {

	@IBOutlet weak var loginScreenlet: LoginScreenlet!
	
	override func viewDidLoad() {
		super.viewDidLoad()

		loginScreenlet.delegate.subscribe(onNext: { [weak self] event in

			if case .actionStarted(let actionName) = event {
				if actionName == WeLoginScreenletView.GoBackActionName {
					self?.navigationController?.popViewController(animated: true)
				}
			}
		})

	}


}

