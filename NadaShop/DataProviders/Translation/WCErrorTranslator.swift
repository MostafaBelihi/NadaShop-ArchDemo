//
//  WCErrorTranslator.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 07/09/2021.
//

import Foundation

class WCErrorTranslator: PTranslator {
	// WCError -> AppError
	func translate(from model: DataError<WCError>) -> AppError {
		return AppError(code: model.error?.code,
						message: model.error?.message,
						type: model.type);
	}
}
