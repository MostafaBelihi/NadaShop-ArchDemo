//
//  ProductDetailsPresenter.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 26/08/2021.
//

import Foundation

protocol PProductDetailsPresenter {
	var item: Product! { get };

	var title: String { get };
	var details: String { get };
	var description: NSAttributedString? { get };
	var price: String { get };
	var originalPrice: String? { get };
	var mainImagePath: String? { get };
	var mainImageURL: URL? { get };
	var images: [Image] { get };
	var attributes: [Attribute] { get };

	var delegate: DataFetchCompletionDelegate? { get set };

	func fetchData(id: Int);
}

class ProductDetailsPresenter: BasePresenter, PProductDetailsPresenter {
	
	// MARK: - Dependencies
	private var productInteractor: PProductInteractor;
	private var dataCoder: PDataCoder;

	// MARK: - Data
	var item: Product!;
	
	weak var delegate: DataFetchCompletionDelegate?;
	
	// MARK: - Data presentation
	var title: String { return item.title }
	
	var details: String { return item.category ?? "" }
	
	var description: NSAttributedString? {
		// TODO: Place htmlTemplate in a stuitable place
		let htmlTemplate = """
  <!doctype html>
  <html>
  <head>
   <style>
  body {
  font-family: -apple-system;
  font-size: \(TextStyle.body.fontSize)px;
  }
   </style>
  </head>
  <body>
   \(item.description)
  </body>
  </html>
  """;
		
		return dataCoder.getHTMLAttributedString(from: htmlTemplate);
	}
	
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
	
	var mainImagePath: String? { return item.thumbnailImageURL }

	var mainImageURL: URL? {
		// TODO: Repeated code
		guard let thumbnailImageURL = item.thumbnailImageURL else {
			return nil;
		}
		
		return URL(string: thumbnailImageURL);
	}

	var images: [Image] { return item.images }

	var attributes: [Attribute] { return item.attributes }

	// MARK: - Init
	init(productInteractor: PProductInteractor, dataCoder: PDataCoder) {
		self.productInteractor = productInteractor;
		self.dataCoder = dataCoder;
	}
	
	// MARK: - Functions
	func fetchData(id: Int) {
		// Don't fetch if there is an active fetching
		guard !isFetching else {
			return;
		}
		
		// Fetch data
		startFetching();
		productInteractor.getItem(id: id) { [weak self] (result: PProductNetworkDataProvider.ProductItemResult) in
			switch result {
				case .success(let data):
					self?.item = data;
					self?.endFetching();
					self?.delegate?.onFetchCompleted(with: .none);
					
				case .failure(let error):
					self?.endFetching();
					self?.delegate?.onFetchFailed(with: error.message ?? error.type.message);
			}
		}
	}

}
