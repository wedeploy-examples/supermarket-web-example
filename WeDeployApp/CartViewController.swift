//
//  CartViewController.swift
//  WeDeployApp
//
//  Created by Victor Galán on 20/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import UIKit
import RxSwift

class CartViewController: UIViewController {

	@IBOutlet weak var cartScreenlet: CartScreenlet!

	@IBOutlet weak var closeButton: UIBarButtonItem! {
		didSet {
			closeButton.setTitleTextAttributes([
				NSForegroundColorAttributeName : UIColor.mainColor,
				NSFontAttributeName: UIFont(name: "loop-icons-12px", size: 24)!
				], for: .normal)
			closeButton.title = "\u{E00D}"
		}
	}

	private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

		navigationController?.navigationBar.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
		navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2);
		navigationController?.navigationBar.layer.shadowRadius = 8;
		navigationController?.navigationBar.layer.shadowOpacity = 1;
		navigationController?.navigationBar.layer.masksToBounds = false
		navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
		navigationController?.navigationBar.shadowImage = UIImage()
		navigationController?.navigationBar.backgroundColor = .white


		cartScreenlet.delegate.subscribe(onNext: { [weak self] event in
			if case .actionStarted(let actionName) = event {
				if actionName == WeCartScreenletView.CloseCartAction {
					self?.dismiss(animated: true, completion: nil)
				}
			}
		})
		.addDisposableTo(disposeBag)
    }

	@IBAction func closeButtonClick(_ sender: UIBarButtonItem) {
		dismiss(animated: true, completion: nil)
	}

}
