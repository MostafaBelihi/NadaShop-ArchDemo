//
//  ProductAttributeCellPresenter.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 09/10/2021.
//

import Foundation

protocol PProductAttributeCellPresenter {
	var item: Attribute { get }
	
	var id: Int { get }
	var name: String { get }
	var isColor: Bool { get }
	var options: [AttributeOption] { get }
}

class ProductAttributeCellPresenter: PProductAttributeCellPresenter {
	
	// MARK: - Data
	var item: Attribute;
	
	// MARK: - Data presentation
	var id: Int { return item.id }
	var name: String { return item.name }
	var isColor: Bool { return item.isColor }
	var options: [AttributeOption] { return item.options }

	// MARK: - Init
	init(with item: Attribute) {
		self.item = item;
	}
	
}

