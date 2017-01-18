//
//  WeUserPortraitScreenletView.swift
//  WeDeployApp
//
//  Created by Victor Galán on 18/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import UIKit
import WeDeploy
import Kingfisher

class WeUserPortraitScreenletView: BaseScreenletView {

	@IBOutlet weak var initialsLabel: UILabel! {
		didSet {
			initialsLabel.backgroundColor = .white
			initialsLabel.textColor = .mainColor
		}
	}
	@IBOutlet weak var userImage: UIImageView!


	override func onCreated() {
		layer.cornerRadius = frame.width/2
		clipsToBounds = true

		userImage.contentMode = .scaleToFill
		userImage.backgroundColor = .black

		perform(actionName: UserPortraitScreenlet.GetCurrentUserAction, params: "")
	}

	override func interactionEnded(actionName: String, result: InteractorOutput) {
		if actionName == UserPortraitScreenlet.GetCurrentUserAction {
			let user = result as! User

			if let photoUrl = user.photoUrl {
				userImage.kf.setImage(with: URL(string: photoUrl)!)
			}
			else if let name = user.name, name.characters.count > 0 {
				initialsLabel.text = "\(user.name?.characters.first!)"
			}
			else {
				initialsLabel.font = UIFont(name: "loop-icons-12px", size: 12)
				initialsLabel.text = "\u{E009}"
			}
		}
	}
}
