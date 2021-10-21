//
//  WooCommerceEndpoint.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 05/09/2021.
//

import Foundation
import Moya

enum WooCommerceEndpoint {
	case data
	case products(listParameters: WCListParameters)
	case product(id: Int)
	case attributes
	case attributeTerms(attributeId: Int, productId: Int?)
}

extension WooCommerceEndpoint: TargetType {
	var baseURL: URL { URL(string: WooCommerceConstants.baseURL)! }
	
	var path: String {
		switch self {
			case .data: return "/data";
			case .products: return "/products";
			case .product(let id): return "/products/\(id)";
			case .attributes: return "/products/attributes";
			case .attributeTerms(let attributeId, _): return "/products/attributes/\(attributeId)/terms";
		}
	}
	
	var method: Moya.Method {
		switch self {
			default: return .get;
		}
	}
	
	var task: Task {
		switch self {
			case .products(let listParameters):
				guard let parameters = listParameters.dict else {
					return .requestPlain;
				}
				
				// TODO: Refactor to cleaner code (enums for statuses, extend parameters model, etc.)
				// This temp code is to get only published products
				var finalParameters: Dictionary<String, Any> = ["status": "publish"];
				finalParameters.merge(parameters) { (current, _) in current };
				
				return.requestParameters(parameters: finalParameters as [String : Any], encoding: URLEncoding.queryString);
				
			case .attributeTerms(_, let productId):
				// This init parameter is to get all possible attributes
				var parameters: Dictionary<String, Any> = ["per_page": 100];
				
				if let productId = productId {
					parameters["product"] = productId;
				}
				
				return.requestParameters(parameters: parameters as [String : Any], encoding: URLEncoding.queryString);
				
			default: return .requestPlain;
		}
	}

	var headers: [String: String]? {
		return ["Content-type": "application/json",
				"Authorization": "Basic \(WooCommerceConstants.basicAuth)"]
	}
	
}
