//
//  SendEmailInteractor.swift
//  WeDeployApp
//
//  Created by Victor Galán on 22/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import Foundation
import WeDeploy
import RxSwift

public struct SendEmailInteractorInput : InteractorInput {

	let subject: String
	let body: String

}


public class SendEmailInteractor : Interactor {

	var sendEmailInteractorParams: SendEmailInteractorInput!

	public override func execute() -> Observable<InteractorOutput> {
		let email = WeDeploy.auth().currentUser?.email ?? ""

		return WeDeploy.email(ScreensSettings.shared!.stringProperty(for: "emailUrl"))
			.sendEmail(from: "shop@shop.com",
				to: email,
				subject: sendEmailInteractorParams.subject,
				body: sendEmailInteractorParams.body)
			.toObservable()
			.map { response in
				response
			}
	}

	public override func validateParams() -> Bool {
		guard let sendEmailInteractorParams = params as? SendEmailInteractorInput else {
			return false
		}

		self.sendEmailInteractorParams = sendEmailInteractorParams

		return true
	}
}
