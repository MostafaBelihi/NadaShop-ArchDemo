//
//  WCProductTranslator.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 16/08/2021.
//

import Foundation

class WCProductTranslator: PTranslator {
	// WCProduct -> Product
	func translate(from model: WCProduct) -> Product {
		var category: String?;
		var thumbnailImageURL: String?;
		
		if model.categories.count > 0 {
			category = model.categories[0].name;
		}
		
		if model.images.count > 0 {
			thumbnailImageURL = model.images[0].src;
		}

		return Product(id: model.id,
					   title: model.name,
					   category: category,
					   price: Double(model.price) ?? 0,
					   originalPrice: (model.price == model.regularPrice) ? 0 : Double(model.regularPrice) ?? 0,
					   description: model.description,
					   thumbnailImageURL: thumbnailImageURL,
					   images: model.images.compactMap({ Image(id: $0.id, url: $0.src, name: $0.name) }),
					   sku: model.sku,
					   weight: model.weight,
					   dimensions: Dimensions(length: model.dimensions.length,
											  width: model.dimensions.width,
											  height: model.dimensions.height),
					   attributes: model.attributes.compactMap({ Attribute(id: $0.id,
																		   name: $0.name,
																		   position: $0.position,
																		   isColor: false,
																		   options: []) })
		);
	}
}
