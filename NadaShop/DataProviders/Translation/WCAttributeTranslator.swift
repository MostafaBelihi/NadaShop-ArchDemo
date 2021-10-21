//
//  WCErrorTranslator.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 07/09/2021.
//

import Foundation

class WCAttributeTranslator: PTranslator {
	// WCAttribute -> Attribute
	func translate(from model: WCAttribute) -> Attribute {
		return Attribute(id: model.id,
						 name: model.name,
						 position: 0,
						 isColor: WCAttributeType(rawValue: model.slug) == .color,
						 options: []);
	}
}
