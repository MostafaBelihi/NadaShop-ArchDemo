//
//  RESTNetworkService.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 05/09/2021.
//

import Foundation
import Moya

class RESTNetworkService<Endpoint: TargetType>: PNetworkService {
	
	// MARK: - Dependencies
	private var provider: MoyaProvider<Endpoint>;
	private var logger: Logging;
	private var dataDecoder: PDataCoder;
	
	// MARK: - Init
	init(logger: Logging, dataDecoder: PDataCoder, isEnabledProviderLogger: Bool = false) {
		self.logger = logger;
		self.dataDecoder = dataDecoder;
		
		if (isEnabledProviderLogger) {
			self.provider = MoyaProvider<Endpoint>(plugins: [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))]);
		}
		else {
			self.provider = MoyaProvider<Endpoint>();
		}
	}
	
	// MARK: - Functions
	func request<TModel: Decodable, TError: Decodable>(_ request: Endpoint,
													   completion: @escaping HTTPResponseClosure<TModel, TError>) {
		
		provider.request(request) { [weak self] result in
			switch result {
				case .success(let response):
					self?.logger.debug("Success");
					self?.successHandler(response: response, completion: completion);
					
				case .failure(let error):
					self?.logger.debug("Failue");
					self?.moyaFailureHandler(error: error, completion: completion);
			}
		}
	}
	
	private func successHandler<TModel: Decodable, TError: Decodable>(response: Response,
																	  completion: @escaping HTTPResponseClosure<TModel, TError>) {
		// Debug Prints
		logger.debug(title: "Service Response", response);
		
		// Build response
		let statusCode = response.statusCode;
		let headers = response.response?.headers;
		
		// Handle Response
		switch statusCode {
			case 200..<299:
				// Decoding
				let model = dataDecoder.decodeModel(ofType: TModel.self, from: response.data);
				
				if let model = model {
					let httpResponse = HTTPResponse<TModel, TError>(result: .success(model), statusCode: statusCode, headers: headers);
					completion(httpResponse);
				}
				else {
					let httpResponse = HTTPResponse<TModel, TError>(result: .failure(DataError(ofType: .decodingError)), statusCode: statusCode, headers: headers);
					completion(httpResponse);
				}
				
			case 401:
				// Decoding
				logger.error(ErrorType.unauthorized.rawValue, ErrorType.unauthorized.message);
				let model = dataDecoder.decodeModel(ofType: TError.self, from: response.data);
				
				if let model = model {
					let httpResponse = HTTPResponse<TModel, TError>(result: .failure(DataError(ofType: .unauthorized, error: model)), statusCode: statusCode, headers: headers);
					completion(httpResponse);
				}
				else {
					let httpResponse = HTTPResponse<TModel, TError>(result: .failure(DataError(ofType: .decodingError)), statusCode: statusCode, headers: headers);
					completion(httpResponse);
				}
				
			default:
				// Decoding
				logger.error(ErrorType.serviceError.rawValue, ErrorType.serviceError.message);
				let model = dataDecoder.decodeModel(ofType: TError.self, from: response.data);
				
				if let model = model {
					let httpResponse = HTTPResponse<TModel, TError>(result: .failure(DataError(ofType: .serviceError, error: model)), statusCode: statusCode, headers: headers);
					completion(httpResponse);
				}
				else {
					let httpResponse = HTTPResponse<TModel, TError>(result: .failure(DataError(ofType: .decodingError)), statusCode: statusCode, headers: headers);
					completion(httpResponse);
				}
		}
		
	}

	// TODO: Temp handling of Moya Error
	private func moyaFailureHandler<TModel: Decodable, TError: Decodable>(error: MoyaError,
																		  completion: @escaping HTTPResponseClosure<TModel, TError>) {
		// Debug Prints
		logger.debug(title: "Moya Error", error);

		// Response
		let httpResponse = HTTPResponse<TModel, TError>(result: .failure(DataError(ofType: .serviceError)), statusCode: 0, headers: .none);
		completion(httpResponse);
		
	}
}
