//
//  ProductNetworkDataProvider.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 05/09/2021.
//

import Foundation

protocol PProductNetworkDataProvider {
	// TODO: Should I use a downsized version of Product entity for listing instead of getting all data not used in the list?
	typealias ProductsListResult = Result<PagedList<Product>, AppError>;
	typealias ProductsListResultClosure = (ProductsListResult) -> Void;

	typealias ProductItemResult = Result<Product, AppError>;
	typealias ProductItemResultClosure = (ProductItemResult) -> Void;
	
	func getAll(listParameters: ListParameters, completion: @escaping ProductsListResultClosure);
	func getItem(id: Int, completion: @escaping ProductItemResultClosure);
}

class ProductNetworkDataProvider: PProductNetworkDataProvider {
	
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
	func getAll(listParameters: ListParameters, completion: @escaping ProductsListResultClosure) {
		let translation = Translation(translator: ListParametersTranslator());
		let parameters = translation.translate(from: listParameters);
		
		networkService.request(.products(listParameters: parameters)) { (response: HTTPResponse<[WCProduct], WCError>) in
			// Extract data from headers
			let totalCount = Int(response.headers?.value(for: "X-WP-Total") ?? "");
			let totalPages = Int(response.headers?.value(for: "X-WP-TotalPages") ?? "");
			
			switch response.result {
				case .success(let data):
					let translation = Translation(translator: WCProductTranslator());
					let items = translation.translate(from: data);
					let list = PagedList(list: items, totalCount: totalCount, totalPages: totalPages, listParameters: listParameters);
					completion(.success(list));
				
				case .failure(let data):
					let translation = Translation(translator: WCErrorTranslator());
					let error = translation.translate(from: data);
					completion(.failure(error));
			}
		}
	}

	func getItem(id: Int, completion: @escaping ProductItemResultClosure) {
		networkService.request(.product(id: id)) { (response: HTTPResponse<WCProduct, WCError>) in
			switch response.result {
				case .success(let data):
					let translation = Translation(translator: WCProductTranslator());
					let item = translation.translate(from: data);
					completion(.success(item));
					
				case .failure(let data):
					let translation = Translation(translator: WCErrorTranslator());
					let error = translation.translate(from: data);
					completion(.failure(error));
			}
		}
	}
}
