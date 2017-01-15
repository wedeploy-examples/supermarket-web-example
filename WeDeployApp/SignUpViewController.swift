//
//  SignUpViewController.swift
//  WeDeployApp
//
//  Created by Victor Galán on 13/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import UIKit
import RxSwift

class SignUpViewController: UIViewController {

	@IBOutlet weak var signUpScreenlet: SignUpScreenlet!
	
	var disposeBag = DisposeBag()

	override func viewDidLoad() {
		super.viewDidLoad()

		signUpScreenlet.delegate.subscribe(onNext: { [weak self] event in

			if case .actionStarted(let actionName) = event {
				if actionName == WeLoginScreenletView.GoBackActionName {
					_ = self?.navigationController?.popViewController(animated: true)
				}
			}

			if case .userCreated(_) = event {
				self?.performSegue(withIdentifier: "main", sender: nil)
			}
		})
		.addDisposableTo(disposeBag)
    }
}
