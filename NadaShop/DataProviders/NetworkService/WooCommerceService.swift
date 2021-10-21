//
//  NetworkService.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 05/09/2021.
//

import Foundation
import Moya

class NetworkService {
	
	// MARK: - Dependencies
	private var provider = MoyaProvider<WooCommerceEndpoint>();
	private var logger: Logging = DebugLogger();
	
	// MARK: - Init
	init(jsonDecoder: JSONDecoder? = nil) {
		if let jsonDecoder =  jsonDecoder {
			self.jsonDecoder = jsonDecoder;
		}
	}
	
	/// JSONDecoder: Add special format handling when decoding fetched data
	private var jsonDecoder: JSONDecoder = {
		let jsonDecoder = JSONDecoder();
		
		// Property casing
		jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase;
		
		// Date format
		let dateFormatter = DateFormatter();
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ";
		jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter);
		
		return jsonDecoder
	}()
	
	
	// MARK: - Functions
	func request<TResponse: Decodable, TError: Decodable>(_ target: WooCommerceEndpoint,
														  completion: @escaping (Result<TResponse, APIError<TError>>) -> Void) {
		
		provider.request(.getAllProducts) { [weak self] result in
			switch result {
				case .success(let response):
					self?.logger.debug("Success");
					print(response.statusCode);
					self?.successHandler(response: response, completion: completion);
					
				case .failure(let error):
					self?.logger.debug("Failed");
					print(error.localizedDescription);
			}
		}
	}
	
	private func successHandler<TResponse: Decodable, TError: Decodable>(response: Response,
																		 completion: @escaping (Result<TResponse, APIError<TError>>) -> Void) {
		// Debug Prints
		logger.debug(title: "Service Response", response);
		
		// Handle Response
		switch response.statusCode {
			case 200..<299:
				// Decoding
				do {
					let values = try self.jsonDecoder.decode(TResponse.self, from: response.data);
					completion(.success(values));
				}
				catch let ex {
					logger.error(title: "Exception", ex);
					completion(.failure(APIError(as: .decodingError)));
				}
				
			case 401:
				logger.error(APIBasicError.unauthorized.rawValue, APIBasicError.unauthorized.message);
				completion(.failure(APIError(as: .unauthorized)));
				
			default:
				// Decoding
				do {
					let values = try self.jsonDecoder.decode(TError.self, from: response.data);
					completion(.failure(APIError(as: .apiError, error: values)));
				}
				catch let ex {
					logger.error(title: "Exception", ex);
					completion(.failure(APIError(as: .decodingError)));
				}
		}
		
	}
}
