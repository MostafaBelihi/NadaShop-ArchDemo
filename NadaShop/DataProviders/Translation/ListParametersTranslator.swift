//
//  ListParametersTranslator.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 13/09/2021.
//

import Foundation

class ListParametersTranslator: PTranslator {
	// ListParameters -> WCListParameters
	func translate(from source: ListParameters) -> WCListParameters {
		return WCListParameters(perPage: source.pageSize,
								page: source.page,
								order: source.sort,
								orderBy: source.sortBy);
	}
}
