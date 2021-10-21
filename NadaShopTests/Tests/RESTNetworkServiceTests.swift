//
//  RESTNetworkServiceTests.swift
//  NadaShopTests
//
//  Created by Mostafa AlBelliehy on 11/09/2021.
//

import XCTest
@testable import NadaShop
import Moya

class RESTNetworkServiceTests: XCTestCase {
	
	// MARK: - Dependencies
	private var moyaProvider: MoyaProvider<WooCommerceEndpoint>!;
	private var networkService: RESTNetworkService<WooCommerceEndpoint>!;
	private var logger: Logging!;
	private var dataCoder: PDataCoder!;
	private var connectionManager: MonitoringConnection!;

	// MARK: - Test Messages
	private let moyaErrorMessaga = "Request failed or no response!";
	private let authErrorMessaga = "Authentication failed!";

	// MARK: - Init
    override func setUpWithError() throws {
		try super.setUpWithError();
		
		self.logger = AppDelegate.dependencyRegistry.container.resolve(Logging.self)!;
		self.dataCoder = AppDelegate.dependencyRegistry.container.resolve(PDataCoder.self)!;
		self.moyaProvider = MoyaProvider<WooCommerceEndpoint>(plugins: [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))]);
		self.networkService = RESTNetworkService<WooCommerceEndpoint>(logger: logger, dataDecoder: dataCoder);
		self.connectionManager = AppDelegate.dependencyRegistry.container.resolve(MonitoringConnection.self)!;

		// Connected?
		try XCTSkipUnless(connectionManager.isReachable, "Test cannot be done while disconnected!")
}
	
    override func tearDownWithError() throws {
		self.logger = nil;
		self.dataCoder = nil;
		self.moyaProvider = nil;
		self.networkService = nil;
		self.connectionManager = nil;

		try super.tearDownWithError();
    }
	
	// MARK: - Tests
	func testServiceAuth() throws {
		// Given
		let promise = expectation(description: "Completion handler invoked");
		var statusCode: Int?;
		
		// When
		moyaProvider.request(.data) { [weak self] (result) in
			switch result {
				case .success(let response):
					statusCode = response.statusCode;
					promise.fulfill();

				case .failure(let error):
					self?.logger.error(title: "Moya Error", error);
					promise.fulfill();
			}
		}
		wait(for: [promise], timeout: 5);
		
		// Then
		XCTAssertNotNil(statusCode, moyaErrorMessaga);
		try XCTSkipIf(statusCode == nil, moyaErrorMessaga);
		XCTAssertNotEqual(statusCode!, 401, authErrorMessaga);
	}
	
	func testEndpointAllProducts() throws {
		// Given
		let promise = expectation(description: "Request succeeds with successful data decoding");
		
		// When
		let parameters = WCListParameters(perPage: 5, page: 1, order: "asc", orderBy: "");
		networkService.request(.products(listParameters: parameters)) { [weak self] (response: HTTPResponse<[WCProduct], WCError>) in
			// Then
			self?.testEndpointResult(result: response.result, with: promise);
		}
		wait(for: [promise], timeout: 5);
	}
	
	func testAllProductsListParametersPerPageCount() throws {
		// Given
		let promise = expectation(description: "Request succeeds with successful data decoding");
		let parameters = WCListParameters(perPage: 5, page: 1, order: "asc", orderBy: "");
		var totalCount: Int?;
		var responseData = [WCProduct]();

		// When
		networkService.request(.products(listParameters: parameters)) { (response: HTTPResponse<[WCProduct], WCError>) in
			switch response.result {
				case .success(let data):
					totalCount = Int(response.headers?.value(for: "X-WP-Total") ?? "");
					responseData = data;
					promise.fulfill();
					
				case .failure(let error):
					promise.fulfill();
					XCTFail("Request failed with error: \(String(describing: error.error?.message))");
			}
		}
		wait(for: [promise], timeout: 5);

		// Then
		try XCTSkipIf(totalCount == nil, "Could not read totalCount!");
		try XCTSkipIf(totalCount! < parameters.perPage, "Resturned set is very small, test is unviable!");
		XCTAssertEqual(responseData.count, parameters.perPage, "Count of returned data does not conform to ListsParameters values!")
	}
	
	func testEndpointProductItem() throws {
		// Given
		let promise = expectation(description: "Request succeeds with successful data decoding");
		
		// When
		networkService.request(.product(id: 33)) { [weak self] (response: HTTPResponse<WCProduct, WCError>) in
			// Then
			self?.testEndpointResult(result: response.result, with: promise);
		}
		wait(for: [promise], timeout: 5);
	}
	
	func testEndpointAttributes() throws {
		// Given
		let promise = expectation(description: "Request succeeds with successful data decoding");
		
		// When
		networkService.request(.attributes) { [weak self] (response: HTTPResponse<[WCAttribute], WCError>) in
			// Then
			self?.testEndpointResult(result: response.result, with: promise);
		}
		wait(for: [promise], timeout: 5);
	}
	
	func testEndpointAttributeTerms() throws {
		// Given
		let promise = expectation(description: "Request succeeds with successful data decoding");
		
		// When
		networkService.request(.attributeTerms(attributeId: 1, productId: 33)) { [weak self] (response: HTTPResponse<[WCAttributeTerm], WCError>) in
			// Then
			self?.testEndpointResult(result: response.result, with: promise);
		}
		wait(for: [promise], timeout: 5);
	}

	// MARK: - Privates
	private func testEndpointResult<TModel, TError>(result: Result<TModel, DataError<TError>>, with promise: XCTestExpectation) {
		switch result {
			case .success(_):
				promise.fulfill();
				
			case .failure(let error):
				promise.fulfill();
				XCTFail("Request failed with error: \(error.type.message)");
		}
	}

}
