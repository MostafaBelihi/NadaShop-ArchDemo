//
//  OfflineDataDecoderTests.swift
//  NadaShopTests
//
//  Created by Mostafa AlBelliehy on 10/09/2021.
//

import XCTest
@testable import NadaShop

/// Methods of this TestCase class tests decoding of service JSON objects having models built of every data type.
/// JSON are static saved in JSON files and are collected from service output.
/// The purpose is to test that models are suitable to expected JSON format of every service data type.
/// If service outputs are changed, update JSON files before running tests.
class OfflineDataDecoderTests: XCTestCase {
	
	// MARK: - Dependencies
	private var dataCoder: PDataCoder!;
	private var logger: Logging!;
	private var bundle: Bundle!;
	
	// MARK: - Test Messages
	private let urlErrorMessaga = "URL cannot be created from the JSON file!!!";
	private let dataErrorMessaga = "JSON data extraction failed!!!";
	private let decodingErrorMessaga = "Decoding failed!";
	
	// MARK: - Init
	override func setUpWithError() throws {
		try super.setUpWithError();
		
		bundle = Bundle(for: OfflineDataDecoderTests.self);
		logger = DebugLogger();
		dataCoder = DataCoder(logger: logger);
	}
	
	override func tearDownWithError() throws {
		bundle = nil;
		logger = nil;
		dataCoder = nil;
		
		try super.tearDownWithError();
	}
	
	// MARK: - Tests
	func testDecodingWCProduct() throws {
		let resourceName = "WCProduct1";
		try testDecoding(forResource: resourceName, ofType: WCProduct.self);
	}
	
	func testDecodingWCAttribute() throws {
		let resourceName = "WCAttribute";
		try testDecoding(forResource: resourceName, ofType: WCAttribute.self);
	}
	
	func testDecodingWCAttributeTerm() throws {
		let resourceName = "WCAttributeTerm";
		try testDecoding(forResource: resourceName, ofType: WCAttributeTerm.self);
	}
	
	func testDecodingWCError() throws {
		let resourceName = "WCError";
		try testDecoding(forResource: resourceName, ofType: WCError.self);
	}
	
	func testDecoding<TModel: Decodable>(forResource resourceName: String,
										 ofType modelType: TModel.Type,
										 completion: ((TModel) -> Void)? = nil) throws {
		// Getting file
		let url = bundle.url(forResource: resourceName, withExtension: "json");
		XCTAssertNotNil(url, urlErrorMessaga);
		try XCTSkipIf(url == nil, urlErrorMessaga);
		
		// Reading file
		let testData = dataCoder.extractJSONData(from: url!);
		XCTAssertNotNil(testData, dataErrorMessaga);
		try XCTSkipIf(testData == nil, dataErrorMessaga);
		
		// Decoding
		let model = dataCoder.decodeModel(ofType: TModel.self, from: testData!);
		logger.debug(model as Any);
		XCTAssertNotNil(model, decodingErrorMessaga);
		
		if let completion = completion {
			completion(model!);
		}
	}
	
}
