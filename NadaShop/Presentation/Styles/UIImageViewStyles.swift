//
//  UIImageStyles.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 19/05/2021.
//

import UIKit

class StyleUIImageViewProductsListThumbnail: StyleUIImageViewBase {
	override func awakeFromNib() {
		super.awakeFromNib()
		
		applyStyles();
	}
	
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		applyStyles();
	}
	
	override func applyStyles() {
		super.applyStyles();

		roundedAll(radius: 15);
	}
}
