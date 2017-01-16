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
				else if actionName == WeSignUpScreenletView.GoToLoginAction {
					_ = self?.navigationController?.popViewController(animated: true)
					let topVC = self?.navigationController?.topViewController as? InitalViewConroller
					topVC?.goLogin = true
				}
			}

			else if case .userCreated(_) = event {
				self?.performSegue(withIdentifier: "main", sender: nil)
			}

		})
		.addDisposableTo(disposeBag)
    }
}
