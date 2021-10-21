//
//  ProductNetworkDataProviderFake.swift
//  NadaShopTests
//
//  Created by Mostafa AlBelliehy on 20/10/2021.
//

import Foundation
@testable import NadaShop

class ProductNetworkDataProviderFake: BaseNetworkDataProviderFake, PProductNetworkDataProvider {
	// MARK: - Functions
	func getAll(listParameters: ListParameters, completion: @escaping ProductsListResultClosure) {
		fatalError("getAll has not been implemented");
	}
	
	func getItem(id: Int, completion: @escaping ProductItemResultClosure) {
		guard let data = WooCommerceEndpoint.product(id: id).sampleData else {
			logger.error("No fake data extracted!");
			completion(.failure(AppError(type: .dataError)));
			return;
		}

		if let networkFake = translateNetworkFake(from: data, networkModelType: WCProduct.self, using: WCProductTranslator()) {
			completion(.success(networkFake));
		}
		else {
			logger.error("Fake data decoding failed!");
			completion(.failure(AppError(type: .decodingError)));
		}
	}
}
