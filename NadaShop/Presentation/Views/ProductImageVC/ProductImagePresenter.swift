//
//  ProductImagePresenter.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 10/10/2021.
//

import Foundation

protocol PProductImagePresenter {
	var imagePath: String { get }
	var imageURL: URL? { get }
}

class ProductImagePresenter: PProductImagePresenter {

	// MARK: - Data
	var imagePath: String;
	
	// MARK: - Data presentation
	var imageURL: URL? { return URL(string: imagePath) }
	
	// MARK: - Init
	init(with imagePath: String) {
		self.imagePath = imagePath;
	}

}

