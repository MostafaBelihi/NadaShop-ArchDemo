//
//  ProductImageCellPresenter.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 07/10/2021.
//

import Foundation

protocol PProductImageCellPresenter {
	var item: Image { get }

	var id: Int { get }
	var imageURL: URL? { get }
}

class ProductImageCellPresenter: PProductImageCellPresenter {
	
	// MARK: - Data
	var item: Image;
	
	// MARK: - Data presentation
	var id: Int { return item.id }
	var imageURL: URL? { return URL(string: item.url) }

	// MARK: - Init
	init(with item: Image) {
		self.item = item;
	}

}
