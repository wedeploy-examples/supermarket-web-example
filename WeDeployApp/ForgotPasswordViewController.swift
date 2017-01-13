//
//  ForgotPasswordViewController.swift
//  WeDeployApp
//
//  Created by Victor Galán on 12/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import UIKit
import RxSwift

class ForgotPasswordViewController: UIViewController {

	@IBOutlet weak var forgotPasswordScreenleet: ForgotPasswordScreenlet!

	var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

		forgotPasswordScreenleet.delegate.subscribe(onNext: { [weak self] event in

			if case .actionStarted(let actionName) = event {
				if actionName == WeLoginScreenletView.GoBackActionName {
					_ = self?.navigationController?.popViewController(animated: true)
				}
			}
			
		})
		.addDisposableTo(disposeBag)
    }

}
