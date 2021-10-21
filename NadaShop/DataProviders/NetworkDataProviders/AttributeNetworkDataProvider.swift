//
//  AttributeNetworkDataProvider.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 07/10/2021.
//

import Foundation

protocol PAttributeNetworkDataProvider {
	typealias AttributesListResult = Result<[Attribute], AppError>;
	typealias AttributesListResultClosure = (AttributesListResult) -> Void;

	typealias AttributeOptionsListResult = Result<[AttributeOption], AppError>;
	typealias AttributeOptionsListResultClosure = (AttributeOptionsListResult) -> Void;
	
	func getAll(completion: @escaping AttributesListResultClosure);
	func getOptions(attributeId: Int, productId: Int?, completion: @escaping AttributeOptionsListResultClosure)
}

class AttributeNetworkDataProvider: PAttributeNetworkDataProvider {
	
	// MARK: - Dependencies
	private var networkService: RESTNetworkService<WooCommerceEndpoint>;
	private var logger: Logging;
	
	
	// MARK: - Init
	init(logger: Logging, dataCoder: PDataCoder) {
		self.logger = logger;
		self.networkService = RESTNetworkService<WooCommerceEndpoint>(logger: logger, dataDecoder: dataCoder);
	}

	// MARK: - Functions
	// TODO: Collect repeated small code blocks within closures (like in .success and .failure clauses) into private methods, I may collect them in a base class and make them generic
	func getAll(completion: @escaping AttributesListResultClosure) {
		networkService.request(.attributes) { (response: HTTPResponse<[WCAttribute], WCError>) in
			switch response.result {
				case .success(let data):
					let translation = Translation(translator: WCAttributeTranslator());
					let items = translation.translate(from: data);
					completion(.success(items));
					
				case .failure(let data):
					let translation = Translation(translator: WCErrorTranslator());
					let error = translation.translate(from: data);
					completion(.failure(error));
			}
		}
	}

	func getOptions(attributeId: Int, productId: Int?, completion: @escaping AttributeOptionsListResultClosure) {
		networkService.request(.attributeTerms(attributeId: attributeId, productId: productId)) { (response: HTTPResponse<[WCAttributeTerm], WCError>) in
			switch response.result {
				case .success(let data):
					let translation = Translation(translator: WCAttributeTermTranslator());
					let items = translation.translate(from: data);
					completion(.success(items));
					
				case .failure(let data):
					let translation = Translation(translator: WCErrorTranslator());
					let error = translation.translate(from: data);
					completion(.failure(error));
			}
		}
	}
	
}

