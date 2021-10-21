//
//  WCErrorTranslator.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 07/09/2021.
//

import Foundation

class WCAttributeTermTranslator: PTranslator {
	// WCAttributeTerm -> AttributeOption
	func translate(from model: WCAttributeTerm) -> AttributeOption {
		return AttributeOption(id: model.id,
							   name: model.name,
							   value: model.slug,
							   description: model.description);
	}
}
