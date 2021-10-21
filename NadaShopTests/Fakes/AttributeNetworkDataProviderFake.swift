//
//  ProductNetworkDataProviderFake.swift
//  NadaShopTests
//
//  Created by Mostafa AlBelliehy on 20/10/2021.
//

import Foundation
@testable import NadaShop

class AttributeNetworkDataProviderFake: BaseNetworkDataProviderFake, PAttributeNetworkDataProvider {
	// MARK: - Functions
	func getAll(completion: @escaping AttributesListResultClosure) {
		guard let data = WooCommerceEndpoint.attributes.sampleData else {
			logger.error("No fake data extracted!");
			completion(.failure(AppError(type: .dataError)));
			return;
		}
		
		if let networkFake = translateNetworkFake(from: data, networkModelType: [WCAttribute].self, using: WCAttributeTranslator()) {
			completion(.success(networkFake));
		}
		else {
			logger.error("Fake data decoding failed!");
			completion(.failure(AppError(type: .decodingError)));
		}
	}
	
	func getOptions(attributeId: Int, productId: Int?, completion: @escaping AttributeOptionsListResultClosure) {
		guard let data = WooCommerceEndpoint.attributeTerms(attributeId: attributeId, productId: productId).sampleData else {
			logger.error("No fake data extracted!");
			completion(.failure(AppError(type: .dataError)));
			return;
		}
		
		if let networkFake = translateNetworkFake(from: data, networkModelType: [WCAttributeTerm].self, using: WCAttributeTermTranslator()) {
			completion(.success(networkFake));
		}
		else {
			logger.error("Fake data decoding failed!");
			completion(.failure(AppError(type: .decodingError)));
		}
	}
}
