//
//  AppError.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 07/09/2021.
//

import Foundation

struct AppError: PError {
	var code: String?
	var propertyName: String?
	var message: String?
	var type: ErrorType;
}
