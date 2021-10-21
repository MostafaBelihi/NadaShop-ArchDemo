//
//  Encodable.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 15/09/2021.
//

import Foundation

extension Encodable {
	var dict : [String: Any]? {
		let encoder = JSONEncoder();
		encoder.keyEncodingStrategy = .convertToSnakeCase;
		
		guard let data = try? encoder.encode(self) else { return nil }
		guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else { return nil }
		return json
	}
}
