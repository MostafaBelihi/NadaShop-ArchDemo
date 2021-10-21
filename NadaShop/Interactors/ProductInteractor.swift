//
//  ProductInteractor.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 30/04/2021.
//

import Foundation

protocol PProductInteractor {
	func getAll(listParameters: ListParameters, completion: @escaping PProductNetworkDataProvider.ProductsListResultClosure);
	func getItem(id: Int, completion: @escaping PProductNetworkDataProvider.ProductItemResultClosure);
}

class ProductInteractor: PProductInteractor {
	// MARK: - Dependencies
	private var productNetworkDataProvider: PProductNetworkDataProvider;
	private var attributeNetworkDataProvider: PAttributeNetworkDataProvider;
	private var logger: Logging;

	// MARK: - Data
	// Product Item Temp Data
	var product: Product?;
	var attributes: [Attribute]?;
	var productItemCompletion: PProductNetworkDataProvider.ProductItemResultClosure?;
	
	// MARK: - Flags
	let loggerGetProductItemOperationTitle = "Get Product Item";
	let productItemMultiCalls = 2;
	var productItemMultiCallsDone = 0;
	var attrinuteTermsMultiCalls = 0;
	var attrinuteTermsMultiCallsDone = 0;
	var resultedInError = false;

	// MARK: - Init
	init(productNetworkDataProvider: PProductNetworkDataProvider,
		 attributeNetworkDataProvider: PAttributeNetworkDataProvider,
		 logger: Logging) {
		
		self.productNetworkDataProvider = productNetworkDataProvider;
		self.attributeNetworkDataProvider = attributeNetworkDataProvider;
		self.logger = logger;
	}

	// MARK: - Functions
	func getAll(listParameters: ListParameters, completion: @escaping PProductNetworkDataProvider.ProductsListResultClosure) {
		productNetworkDataProvider.getAll(listParameters: listParameters) { (result: PProductNetworkDataProvider.ProductsListResult) in
			switch result {
				case .success(let items):
					completion(.success(items));
					
				case .failure(let error):
					completion(.failure(error));
			}
		}
	}

	func getItem(id: Int, completion: @escaping PProductNetworkDataProvider.ProductItemResultClosure) {
		// Assign completion handler for later use
		productItemCompletion = completion;
		
		// Get init product item and main attributes data
		logger.debug(title: loggerGetProductItemOperationTitle, "Init: Get init product item and main attributes data");
		getProduct(id: id);
		getMainAttributes();
	}
	
}

// MARK: - GetProductItem Subsequent Calls
// TODO: I may search for an improved way to handle this functionality
extension ProductInteractor {
	private func getProduct(id: Int) {
		logger.debug(title: loggerGetProductItemOperationTitle, "Getting init product data");
		
		productNetworkDataProvider.getItem(id: id) { (result: PProductNetworkDataProvider.ProductItemResult) in
			switch result {
				case .success(let item):
					// Assign to temp data
					self.product = item;
					
					// Increment done calls
					self.productItemMultiCallsDone += 1;
					
					// Complete next level of data
					self.completeAttributeData();
					
				case .failure(let error):
					self.logger.error(title: self.loggerGetProductItemOperationTitle, error);
					self.completeProductItem(with: error);
			}
		}
	}
	
	private func getMainAttributes() {
		logger.debug(title: loggerGetProductItemOperationTitle, "Getting main attributes data");
		
		attributeNetworkDataProvider.getAll() { (result: PAttributeNetworkDataProvider.AttributesListResult) in
			switch result {
				case .success(let item):
					// Assign to temp data
					self.attributes = item;
					
					// Increment done calls
					self.productItemMultiCallsDone += 1;
					
					// Complete next level of data
					self.completeAttributeData();
					
				case .failure(let error):
					self.logger.error(title: self.loggerGetProductItemOperationTitle, error);
					self.completeProductItem(with: error);
			}
		}
	}
	
	private func completeAttributeData() {
		self.logger.debug(title: self.loggerGetProductItemOperationTitle, "completeAttributeData");
		
		// Don't act until all calls are done
		if (productItemMultiCallsDone >= productItemMultiCalls) {
			self.logger.debug(title: self.loggerGetProductItemOperationTitle, "completeAttributeData: All calls done!!!");
			
			guard let product = product, let attributes = attributes else {
				logger.error("Incomplete data!");
				completeProductItem(with: AppError(message: "Incomplete data!", type: .unknownError));
				return;
			}
			
			if (product.attributes.count == 0) {
				self.logger.debug(title: self.loggerGetProductItemOperationTitle, "No attributes, to finalize product data");
				self.completeProductItem();
			}
			
			// Loop and call backend service to get options per attribute
			self.logger.debug(title: self.loggerGetProductItemOperationTitle, "Loop and call backend service to get options per attribute");
			attrinuteTermsMultiCalls = product.attributes.count;
			for i in 0..<product.attributes.count {
				getAttributeOptions(attributeId: product.attributes[i].id, productId: product.id, index: i);
				
				// Complete other properties of attributes until options are retrieved
				self.logger.debug(title: self.loggerGetProductItemOperationTitle, "Complete other properties of attributes until options are retrieved");
				self.product?.attributes[i].isColor = attributes.first(where: { $0.id == product.attributes[i].id })?.isColor ?? false;
			}
		}
	}
	
	private func getAttributeOptions(attributeId: Int, productId: Int, index: Int) {
		logger.debug(title: loggerGetProductItemOperationTitle, "Getting attribute options for attribute of id: \(attributeId)");
		
		attributeNetworkDataProvider.getOptions(attributeId: attributeId, productId: productId) { (result: PAttributeNetworkDataProvider.AttributeOptionsListResult) in
			switch result {
				case .success(let item):
					// Assign to temp data
					self.product?.attributes[index].options = item;
					
					// Increment done calls
					self.attrinuteTermsMultiCallsDone += 1;
					
					// Finalize product item completion
					self.completeProductItem();
					
				case .failure(let error):
					self.logger.error(title: self.loggerGetProductItemOperationTitle, error);
					self.completeProductItem(with: error);
			}
		}
	}
	
	private func completeProductItem() {
		self.logger.debug(title: self.loggerGetProductItemOperationTitle, "completeProductItem");
		
		if (attrinuteTermsMultiCallsDone >= attrinuteTermsMultiCalls) {
			self.logger.debug(title: self.loggerGetProductItemOperationTitle, "completeProductItem: All calls done!!!");
			
			guard let product = product else {
				logger.error("Incomplete data!");
				completeProductItem(with: AppError(message: "Incomplete data!", type: .unknownError));
				return;
			}
			
			// Hand temp data to final completion handler
			self.logger.debug(title: self.loggerGetProductItemOperationTitle, "Operation is complete, calling final completion handler");
			productItemCompletion!(.success(product));
			
			// Free all temp data and reset all flags
			self.product = nil;
			self.attributes = nil;
			self.productItemCompletion = nil;
			self.productItemMultiCallsDone = 0;
			self.attrinuteTermsMultiCalls = 0;
			self.attrinuteTermsMultiCallsDone = 0;
			self.resultedInError = false;
		}
	}
	
	private func completeProductItem(with error: AppError) {
		// Error completion (only once)
		if (!resultedInError) {
			resultedInError = true;
			productItemCompletion!(.failure(error));
		}
	}
}
