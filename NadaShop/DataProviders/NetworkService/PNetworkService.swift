//
//  PNetworkService.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 04/09/2021.
//

import Foundation

protocol PNetworkService {
	typealias HTTPResponseClosure<TModel: Decodable, TError: Decodable> = (HTTPResponse<TModel, TError>) -> Void;
	associatedtype RequestType;
	func request<TModel: Decodable, TError: Decodable>(_ request: RequestType,
													   completion: @escaping HTTPResponseClosure<TModel, TError>);
}
