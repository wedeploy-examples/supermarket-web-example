//
//  LoadDataInteractor.swift
//  WeDeployApp
//
//  Created by Victor Galán on 16/01/2017.
//  Copyright © 2017 liferay. All rights reserved.
//

import Foundation
import WeDeploy
import RxSwift

public protocol JSONDecodable {
	init(json: [String: AnyObject])
}

public struct LoadDataInteractorInput : InteractorInput {
	let resourceName: String
	let type: JSONDecodable.Type
	let dataQuery: LoadDataQuery

	init(resourceName: String, type: JSONDecodable.Type, dataQuery: LoadDataQuery) {
		self.resourceName = resourceName
		self.type = type
		self.dataQuery = dataQuery
	}
}

public class LoadDataQuery {
	var query = Query()
	var filter: Filter?

	public func orderBy(field: String, order: Query.Order) -> Self {
		self.query = query.sort(name: field, order: order)
		return self
	}

	public func filter(filter: Filter) -> Self {
		if let filter = self.filter {
			self.filter = filter.and(filter)
		}
		else {
			self.filter = filter
		}

		return self
	}

}


extension Array : InteractorOutput { }

open class LoadDataInteractor : Interactor {

	var loadDataParams: LoadDataInteractorInput!

	open override func execute() -> Observable<InteractorOutput> {

	let query = WeDeploy.data("data.easley84.wedeploy.io")
			.query(query: loadDataParams.dataQuery.query)

	if let filter = loadDataParams.dataQuery.filter {
		query.filter(filter: filter)
	}

	return query.get(resourcePath: loadDataParams.resourceName)
			.toObservable()
			.map { [unowned self] json -> [JSONDecodable] in
				return json.map {
					self.loadDataParams.type.init(json: $0)
				}
			}
	}

	open override func validateParams() -> Bool {
		guard let loadDataParams = params as? LoadDataInteractorInput
			else { return false }

		self.loadDataParams = loadDataParams

		return true
	}
	
}
