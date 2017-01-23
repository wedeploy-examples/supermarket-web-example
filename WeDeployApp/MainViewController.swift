//
//  MainViewController.swift
//  WeDeployApp
//
//  Created by Victor Galán on 16/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import UIKit
import RxSwift

public class MainViewController : UIViewController {

	@IBOutlet weak var dataListScreenlet: DataListScreenlet!

	var disposeBag = DisposeBag()

	public override func viewDidLoad() {
		super.viewDidLoad()

		dataListScreenlet.delegate.subscribe(onNext: { [weak self] event in
			if case .actionStarted(let actionName) = event {
				if actionName == WeDataListScreenletView.LogoutAction {
					_ = self?.navigationController?.popViewController(animated: true)
				}
				else if actionName == WeDataListScreenletView.OpenCartAction {
					self?.performSegue(withIdentifier: "cart", sender: nil)
				}
			}
		})
		.addDisposableTo(disposeBag)

		setNeedsStatusBarAppearanceUpdate()
	}

	public override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
}
