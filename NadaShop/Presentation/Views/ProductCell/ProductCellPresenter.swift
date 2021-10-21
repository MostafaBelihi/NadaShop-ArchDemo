//
//  ProductCellPresenter.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 05/08/2021.
//

import Foundation

protocol PProductCellPresenter {
	var item: Product { get }
	
	var title: String { get }
	var details: String { get }
	var price: String { get }
	var originalPrice: String? { get }
	var thumbnailImage: URL? { get }
}

class ProductCellPresenter: PProductCellPresenter {

	// MARK: - Data
	var item: Product;
	
	// MARK: - Data presentation
	var title: String { return item.title }
	
	var details: String { return item.category ?? "" }
	
	var price: String {
		// TODO: Repeated code
		let price: Double = item.price;
		let currency = Math.getCurrency(fromCurrencyCode: GlobalConstants.activeCurrencyCode);
		return Math.formatMoneyNumber(number: price, currency: currency ?? .none, shouldGetCurrencySymbol: true);
	}
	
	var originalPrice: String? {
		// TODO: Repeated code
		guard item.originalPrice > 0 else {
			return nil;
		}

		let originalCurrency = Math.getCurrency(fromCurrencyCode: GlobalConstants.activeCurrencyCode);
		return Math.formatMoneyNumber(number: item.originalPrice, currency: originalCurrency ?? .none, shouldGetCurrencySymbol: true);
	}

	var thumbnailImage: URL? {
		// TODO: Repeated code
		guard let thumbnailImageURL = item.thumbnailImageURL else {
			return nil;
		}

		return URL(string: thumbnailImageURL);
	}
	
	// MARK: - Init
	init(with item: Product) {
		self.item = item;
	}
}
