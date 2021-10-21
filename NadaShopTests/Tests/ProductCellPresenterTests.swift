//
//  ProductCellPresenterTests.swift
//  NadaShopTests
//
//  Created by Mostafa AlBelliehy on 11/09/2021.
//

import XCTest
@testable import NadaShop

// TODO: (Added to backlog) Remove OfflineDataDecoderTests from inheritance, decode models using another normal method.
class ProductCellPresenterTests: OfflineDataDecoderTests {
	
	// MARK: - Dependencies

	// MARK: - Test Messages
	private let titleErrorMessaga = "title incorrect!";
	private let detailsErrorMessaga = "details incorrect!";
	private let priceErrorMessaga = "price incorrect!";
	private let originalPriceErrorMessaga = "originalPrice incorrect!";
	private let imageThumbnailErrorMessaga = "thumbnailImage incorrect!";

	// MARK: - Init
    override func setUpWithError() throws {
		try super.setUpWithError();
    }

    override func tearDownWithError() throws {
		try super.tearDownWithError();
    }
	
	// MARK: - Tests
	func testPresentationWithoutDiscount() throws {
		// Given
		let resourceName = "WCProduct1";
		
		// When
		try super.testDecoding(forResource: resourceName, ofType: WCProduct.self){ [weak self] (model) in
			let translation = Translation(translator: WCProductTranslator());
			let presenter = ProductCellPresenter(with: translation.translate(from: model));
			
			// Then
			XCTAssertEqual(presenter.title, "Product 1 Name", (self?.titleErrorMessaga)!);
			XCTAssertEqual(presenter.details, "Uncategorized", (self?.detailsErrorMessaga)!);
			XCTAssertEqual(presenter.price, "109 EGP", (self?.priceErrorMessaga)!);
			XCTAssertEqual(presenter.originalPrice, nil, (self?.originalPriceErrorMessaga)!);
			XCTAssertEqual(presenter.thumbnailImage?.absoluteString,
						   "https://wp.m-belihi.com/wp-content/uploads/2021/09/item_XL_132420043_f159e496dca5b.jpg",
						   (self?.imageThumbnailErrorMessaga)!);
		}
	}

	func testPresentationWithDiscount() throws {
		// Given
		let resourceName = "WCProduct2";
		
		// When
		try super.testDecoding(forResource: resourceName, ofType: WCProduct.self){ [weak self] (model) in
			let translation = Translation(translator: WCProductTranslator());
			let presenter = ProductCellPresenter(with: translation.translate(from: model));
			
			// Then
			XCTAssertEqual(presenter.title, "Product 2 Name", (self?.titleErrorMessaga)!);
			XCTAssertEqual(presenter.details, "Uncategorized", (self?.detailsErrorMessaga)!);
			XCTAssertEqual(presenter.price, "1,250 EGP", (self?.priceErrorMessaga)!);
			XCTAssertEqual(presenter.originalPrice, "1,260 EGP", (self?.originalPriceErrorMessaga)!);
			XCTAssertEqual(presenter.thumbnailImage?.absoluteString,
						   "https://wp.m-belihi.com/wp-content/uploads/2021/09/item_XL_132420043_f159e496dca5b.jpg",
						   (self?.imageThumbnailErrorMessaga)!);
		}
	}

}
