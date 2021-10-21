//
//  UIViewStyles.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 05/10/2021.
//

import UIKit

class StyleUIViewProductsDetailSection: StyleUIViewBase {
	override func awakeFromNib() {
		super.awakeFromNib()
		
		applyStyles();
	}
	
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
	}
	
	override func applyStyles() {
		super.applyStyles();
		
		addBordersWithMargin(edges: .top, color: .lightGray, thickness: 1.0, margin: 3.5);
	}
}
