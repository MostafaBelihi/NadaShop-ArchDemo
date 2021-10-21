//
//  Product.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 14/08/2021.
//

import Foundation

struct Product {
	var id: Int;
	var title: String;
	var category: String?;
	var price: Double;
	var originalPrice: Double;
	var description: String;
	var currencyCode: String?;
	var thumbnailImageURL: String?;
	var images: [Image];
	var sku: String?;
	var weight: String?;
	var dimensions: Dimensions;
	var attributes: [Attribute];
}
