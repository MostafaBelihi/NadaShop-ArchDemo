//
//  WooCommerceEndpoint.swift
//  NadaShopTests
//
//  Created by Mostafa AlBelliehy on 20/10/2021.
//

import Foundation
@testable import NadaShop

extension WooCommerceEndpoint {
	var sampleData: Data? {
		let logger = DebugLogger();
		let dataCoder = DataCoder(logger: logger);
		let bundle = Bundle(for: RESTNetworkServiceTests.self);
		
		switch self {
			case .product(let id) :
				let fakeResourceName = "WCProduct\(id)";
				guard let url = bundle.url(forResource: fakeResourceName, withExtension: "json") else { return nil }
				return dataCoder.extractJSONData(from: url);

			case .attributes :
				let fakeResourceName = "WCAttributes";
				guard let url = bundle.url(forResource: fakeResourceName, withExtension: "json") else { return nil }
				return dataCoder.extractJSONData(from: url);

			case .attributeTerms(_, _) :
				let fakeResourceName = "WCAttributeTerms";
				guard let url = bundle.url(forResource: fakeResourceName, withExtension: "json") else { return nil }
				return dataCoder.extractJSONData(from: url);

			default: return nil;
		}
	}
}
