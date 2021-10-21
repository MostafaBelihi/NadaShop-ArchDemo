//
//  WCProduct.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 05/09/2021.
//

import Foundation

// MARK: - WCProduct
struct WCProduct: Codable {
	var id: Int
	var name: String
//	var slug: String
//	var permalink: String
//	var dateCreated: Date
//	var dateCreatedGmt: Date
//	var dateModified: Date
//	var dateModifiedGmt: Date
	var type: String
	var status: String
	var featured: Bool
	var catalogVisibility: String
	var description: String
	var shortDescription: String
	var sku: String
	var price: String
	var regularPrice: String
	var salePrice: String
//	var dateOnSaleFrom: Date?
//	var dateOnSaleFromGmt: Date?
//	var dateOnSaleTo: Date?
//	var dateOnSaleToGmt: Date?
//	var onSale: Bool
//	var purchasable: Bool
//	var totalSales: Int
//	var virtual: Bool
//	var downloadable: Bool
	// var downloads: [Any]
//	var downloadLimit: Int
//	var downloadExpiry: Int
//	var externalUrl: String
//	var buttonText: String
//	var taxStatus: String
//	var taxClass: String
	var manageStock: Bool
	var stockQuantity: Int?
//	var backorders: String
//	var backordersAllowed: Bool
//	var backordered: Bool
//	var lowStockAmount: Int?
//	var soldIndividually: Bool
	var weight: String
	var dimensions: WCDimensions
//	var shippingRequired: Bool
//	var shippingTaxable: Bool
//	var shippingClass: String
//	var shippingClassId: Int
//	var reviewsAllowed: Bool
//	var averageRating: String
//	var ratingCount: Int
	// var upsellIdS: [Any]
	// var crossSellIdS: [Any]
	var parentId: Int
//	var purchaseNote: String
	var categories: [WCCategory]
	// var tags: [Any]
	var images: [WCImage]
	var attributes: [WCProductAttribute]
	// var defaultAttributes: [Any]
	// var variations: [Any]
	// var groupedProducts: [Any]
//	var menuOrder: Int
//	var priceHtml: String
//	var relatedIds: [Int]
//	var metaData: [WCMetaDatum]
//	var stockStatus: String
}

// MARK: - Category
struct WCCategory: Codable {
	var id: Int
	var name: String
	var slug: String
}

// MARK: - Dimensions
struct WCDimensions: Codable {
	var length: String
	var width: String
	var height: String
}

// MARK: - WCAttribute
struct WCProductAttribute: Codable {
	let id: Int
	let name: String
	let position: Int
	let visible: Bool
	let variation: Bool
	let options: [String]
}

// MARK: - Image
struct WCImage: Codable {
	var id: Int
	var dateCreated: Date
	var dateCreatedGmt: Date
	var dateModified: Date
	var dateModifiedGmt: Date
	var src: String
	var name: String
	var alt: String
}

// MARK: - Links
//struct WCLink: Codable {
//	var linksSelf: [WCCollection]
//	var collection: [WCCollection]
//}

// MARK: - Collection
//struct WCCollection: Codable {
//	var href: String
//}

// MARK: - MetaDatum
//struct WCMetaDatum: Codable {
//	var id: Int
//	var key: String
//	var value: String
//}
