//
//  UIButtonStyles.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 21/09/2021.
//

import UIKit

class StyleUIButton: StyleUIButtonBase {
	override func awakeFromNib() {
		super.awakeFromNib()
		
		applyStyles();
	}
	
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		applyStyles();
	}
	
	override func applyStyles() {
		super.applyStyles();
		
		roundedAll(radius: 8);
	}
}
