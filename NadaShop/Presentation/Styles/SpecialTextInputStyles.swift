//
//  UIViewStyles.swift
//  My-Stocks
//
//  Created by Mostafa AlBelliehy on 18/04/2020.
//  Copyright © 2020 Mostafa AlBelliehy. All rights reserved.
//

import UIKit

class StyleSpecialTextInputBase: SpecialTextInput {
	override func awakeFromNib() {
		super.awakeFromNib()
		
		applyStyles();
	}
	
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		applyStyles();
	}
	
	func applyStyles() {
		// Look
		self.viewContent.backgroundColor = AppColor.inputBackground;
		self.viewContent.roundedAll(radius: 6);
		self.viewContent.clipsToBounds = true;
		self.viewContent.layer.borderWidth = 1.3;
		self.viewContent.layer.borderColor = AppColor.inputStroke.cgColor;
		
		// Text
		self.txtInput.font = TextStyle.body.font;
	}
}
