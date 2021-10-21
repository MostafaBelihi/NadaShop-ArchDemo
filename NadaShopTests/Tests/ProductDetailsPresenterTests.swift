//
//  ProductDetailsPresenterTests.swift
//  NadaShopTests
//
//  Created by Mostafa AlBelliehy on 19/10/2021.
//

import XCTest
@testable import NadaShop

class ProductDetailsPresenterTests: XCTestCase {

	// MARK: - Dependencies
	private var dataCoder: PDataCoder!;
	private var interactor: PProductInteractor!;

	// MARK: - Test Messages
	private let titleErrorMessaga = "title incorrect!";
	private let detailsErrorMessaga = "details incorrect!";
	private let priceErrorMessaga = "price incorrect!";
	private let originalPriceErrorMessaga = "originalPrice incorrect!";
	private let imageThumbnailErrorMessaga = "thumbnailImage incorrect!";
	private let imagesErrorMessaga = "images are missing!";
	private let attributesErrorMessaga = "attributes are missing!";

	// MARK: - Init
	override func setUpWithError() throws {
		try super.setUpWithError();
		
		let logger = DebugLogger();
		dataCoder = DataCoder(logger: logger);
		interactor = ProductInteractor(productNetworkDataProvider: ProductNetworkDataProviderFake(),
									   attributeNetworkDataProvider: AttributeNetworkDataProviderFake(),
									   logger: logger);
	}
	
	override func tearDownWithError() throws {
		dataCoder = nil;
		interactor = nil;

		try super.tearDownWithError();
	}

	// MARK: - Tests
	func testProductItem1() throws {
		// Given
		let presenter = ProductDetailsPresenter(productInteractor: interactor, dataCoder: dataCoder);
		
		// When
		presenter.fetchData(id: 29);
		
		// Then
		guard presenter.item != nil else {
			XCTFail("Data could not be extracted!");
			return;
		}
		
		XCTAssertEqual(presenter.title, "04- Samsung Galaxy A21s SM-A217FZBGEGY Dual SIM Mobile - 6.5 Inch, 64 GB, 4 GB RAM, 4G LTE - Blue", titleErrorMessaga);
		XCTAssertEqual(presenter.details, "Smartphones", detailsErrorMessaga);
		XCTAssertEqual(presenter.price, "176.99 EGP", priceErrorMessaga);
		XCTAssertEqual(presenter.originalPrice, nil, originalPriceErrorMessaga);
		XCTAssertEqual(presenter.mainImagePath,
					   "https://wp.m-belihi.com/wp-content/uploads/2021/09/item_XL_130988594_8113c2bf69009.jpg",
					   imageThumbnailErrorMessaga);
		XCTAssertEqual(presenter.images.count, 1, originalPriceErrorMessaga);
		XCTAssertEqual(presenter.attributes.count, 0, originalPriceErrorMessaga);
	}

	func testProductItem2() throws {
		// Given
		let presenter = ProductDetailsPresenter(productInteractor: interactor, dataCoder: dataCoder);

		// When
		presenter.fetchData(id: 33);

		// Then
		guard presenter.item != nil else {
			XCTFail("Data could not be extracted!");
			return;
		}
		
		XCTAssertEqual(presenter.title, "00-Ravin Plain Chest Pocket Long Sleeves Shirt for Men", titleErrorMessaga);
		XCTAssertEqual(presenter.details, "Men's Wear", detailsErrorMessaga);
		XCTAssertEqual(presenter.price, "100 EGP", priceErrorMessaga);
		XCTAssertEqual(presenter.originalPrice, "120 EGP", originalPriceErrorMessaga);
		XCTAssertEqual(presenter.mainImagePath,
					   "https://wp.m-belihi.com/wp-content/uploads/2021/09/51fPiWXtuvS._AC_SX569_.jpg",
					   imageThumbnailErrorMessaga);
		XCTAssertEqual(presenter.images.count, 11, originalPriceErrorMessaga);
		XCTAssertEqual(presenter.attributes.count, 2, originalPriceErrorMessaga);
	}

}
