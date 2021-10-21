//
//  HTTPResponse.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 13/09/2021.
//

import Foundation
import Alamofire

struct HTTPResponse<TModel, TError> {
	var result: Result<TModel, DataError<TError>>;
	var statusCode: Int;
	var headers: Alamofire.HTTPHeaders?;
}
