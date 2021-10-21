//
//  MainRouter.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 26/08/2021.
//

import UIKit

protocol PProductRouter {
	func viewProductDetails(for id: Int, from sourceView: UIViewController);
	func viewProductImage(for imagePath: String, from sourceView: UIViewController);
}

class ProductRouter: PProductRouter {
	
	// MARK: - Dependencies
	private var di: PDependencyRegistry;
	
	// MARK: - Init
	init(di: PDependencyRegistry) {
		self.di = di;
	}
	
	// MARK: - Functions
	func viewProductDetails(for id: Int, from sourceView: UIViewController) {
		let vc = di.makeProductDetailsVC(with: id);
		sourceView.navigationController?.pushViewController(vc, animated: true);
	}

	func viewProductImage(for imagePath: String, from sourceView: UIViewController) {
		let vc = di.makeProductImageVC(with: imagePath);
		sourceView.present(vc, animated: true);
	}
	
}
