//
//  ErrorType.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 07/09/2021.
//

import Foundation

protocol PError: Error {
	var type: ErrorType { get set };
}

struct DataError<TError> : PError {
	init(ofType type: ErrorType, error: TError? = nil) {
		self.type = type;
		
		if let error = error {
			self.error = error;
		}
	}
	
	var type: ErrorType;
	var error: TError?;
}

enum ErrorType : String {
	case unknownError
	case serviceError
	case unauthorized
	case decodingError
	case invalidEndpoint
	case invalidResponse
	case noData
	case dataError
	case apiLimitReached
	case noConnection
	
	var message: String {
		return NSLocalizedString(self.rawValue, comment: "");
	}
}
