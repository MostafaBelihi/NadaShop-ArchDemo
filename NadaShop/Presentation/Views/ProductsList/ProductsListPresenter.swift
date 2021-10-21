//
//  ProductsListPresenter.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 05/08/2021.
//

import Foundation

protocol PProductsListPresenter {
	var items: [Product] { get };

	var totalCount: Int { get };
	var totalPages: Int { get };
	var listParameters: ListParameters { get };

	var delegate: DataFetchCompletionDelegate? { get set };

	func fetchData();
	func reset();
}

class ProductsListPresenter: BasePresenter, PProductsListPresenter {
	
	// MARK: - Dependencies
	private var productInteractor: PProductInteractor;
	
	// MARK: - Data
    var items: [Product];
	
	var totalCount: Int;
	var totalPages: Int;
	var listParameters: ListParameters;
	
	weak var delegate: DataFetchCompletionDelegate?;
	
	// MARK: - Init
	init(productInteractor: PProductInteractor) {
		self.productInteractor = productInteractor;
		
		items = [];
		totalCount = 0;
		totalPages = 0;
		listParameters = ViewConstants.defaultListParameters;
	}

	// MARK: - Functions
	func reset() {
		items = [];
		totalCount = 0;
		totalPages = 0;
		listParameters = ViewConstants.defaultListParameters;
	}
	
	func fetchData() {
		// Don't fetch if there is an active fetching
		guard !isFetching else {
			return;
		}
		
		// Prepare paging parameters
		if (items.count > 0) {
			listParameters.page += 1;
		}

		// Fetch data
		startFetching();
		productInteractor.getAll(listParameters: listParameters) { [weak self] (result: PProductNetworkDataProvider.ProductsListResult) in
			switch result {
				case .success(let data):
					self?.items.append(contentsOf: data.list);
					self?.totalCount = data.totalCount ?? data.list.count;
					self?.totalPages = data.totalPages ?? 1;
					
					self?.endFetching();
					
					if (data.listParameters.page == 1) {
						// First fetch
						self?.delegate?.onFetchCompleted(with: .none);
					}
					else {
						// Next pages
						let newIndexes = self?.calculateNewIndexes(from: data.list);
						self?.delegate?.onFetchCompleted(with: newIndexes!);
					}
					
				case .failure(let error):
					self?.endFetching();
					self?.delegate?.onFetchFailed(with: error.message ?? error.type.message);
			}
		}
	}
	
	// Generates indexes for all items within a newly fetched page of a list
	private func calculateNewIndexes(from newItems: [Product]) -> [Int] {
		let startIndex = items.count - newItems.count;
		let endIndex = startIndex + newItems.count;
		return (startIndex..<endIndex).map { $0 }
	}

}
