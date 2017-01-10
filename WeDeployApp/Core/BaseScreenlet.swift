//
//  BaseScreenlet.swift
//  WeDeployApp
//
//  Created by Victor Galán on 05/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import UIKit
import RxSwift

public typealias ActionPerformer = (String, InteractorInput) -> ()

public class BaseScreenlet : UIView {

	var screenletView: BaseScreenletView?
	var interactors: [String : Interactor]?
	var viewName: String? = ""

	var disposeBag = DisposeBag()

	public required init(frame: CGRect, viewName: String) {
		super.init(frame: frame)
		self.viewName = viewName

		initialize()
	}
	
	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	public override func awakeFromNib() {
		initialize()
	}

	public func initialize() {

		guard let definition = ScreenletWarehouse.shared.definitionFor(screenlet: type(of: self))
			else {
				print("no definition for this screenlet ")
				return
			}

		self.interactors = [:]

		for (actionName, interactor) in definition.interactors {
			 interactors![actionName] = interactor.init()
		}

		if !definition.viewNames.contains(viewName!) {
			print("This view is not included in the definition, falling back to default viewname")
			viewName = definition.viewNames.first
		}

		loadView()
	}

	public func loadView() {
		if let view = viewFrom(nibName: viewName!, type: BaseScreenletView.self) {
			self.screenletView = view
			view.actionPerformer = perform
			addSubview(view)

			view.translatesAutoresizingMaskIntoConstraints = false
			view.topAnchor.constraint(equalTo: topAnchor).isActive = true
			view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
			view.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
			view.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		}
	}

	public func viewFrom<T: UIView>(nibName: String, type: T.Type? = T.self) -> T? {
		for bundle in Bundle.allBundles {
			if let _ = bundle.path(forResource: nibName, ofType: "nib") {
				guard let nib = bundle.loadNibNamed(nibName, owner: nil, options: [:])
					else { break }

				if let view = nib[0] as? T {
					return view
				}
			}
		}

		return nil
	}

	public func perform(actionName: String, params: InteractorInput) {

		let interactor = interactorFor(actionName: actionName)

		interactor?.start(params: params)
			.do(onSubscribe: { [weak self] in
				self?.interactionStarted(actionName: actionName)
			})
			.subscribe(
					onNext: { [weak self] result in
						self?.interactionEnded(actionName: actionName, result: result)
					},
					onError: { [weak self] error in
						self?.interactionErrored(actionName: actionName, error: error)
					}
				)
				.addDisposableTo(disposeBag)
	}

	public func interactorFor(actionName: String) -> Interactor? {

		return interactors?[actionName]
	}

	public func interactionStarted(actionName: String) {
		screenletView?.interactionStarted(actionName: actionName)
	}

	public func interactionEnded(actionName: String, result: InteractorOutput) {
		screenletView?.interactionEnded(actionName: actionName, result: result)
	}

	public func interactionErrored(actionName: String, error: Error) {
		screenletView?.interactionErrored(actionName: actionName, error: error)
	}

}


public protocol InteractorInput {

}

public protocol InteractorOutput {

}
