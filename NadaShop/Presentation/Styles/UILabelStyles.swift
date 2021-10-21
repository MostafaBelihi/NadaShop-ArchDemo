//
//  UILabelStyles.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 09/05/2021.
//

import UIKit

// MARK: - ProductsList
class StyleUILabelProductsListTitle: StyleUILabelBase {
	override func awakeFromNib() {
		super.awakeFromNib()
		
		applyStyles();
	}
	
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		applyStyles();
	}
	
	override func applyStyles() {
		super.applyStyles();
		
		font = AppFont(size: !DeviceTrait.isLargeWindow ? 20 : 24, weight: .medium).font;
	}
}

class StyleUILabelProductsListDetails: StyleUILabelBase {
	override func awakeFromNib() {
		super.awakeFromNib()
		
		applyStyles();
	}
	
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		applyStyles();
	}
	
	override func applyStyles() {
		super.applyStyles();
		
		font = AppFont(size: !DeviceTrait.isLargeWindow ? 16 : 22, weight: .regular).font;
		textColor = AppColor.textSecondary;
	}
}

class StyleUILabelProductsListPrice: StyleUILabelBase {
	override func awakeFromNib() {
		super.awakeFromNib()
		
		applyStyles();
	}
	
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		applyStyles();
	}
	
	override func applyStyles() {
		super.applyStyles();
		
		font = AppFont(size: !DeviceTrait.isLargeWindow ? 16 : 22, weight: .regular).font;
	}
}

class StyleUILabelProductsListPriceDiscount: StyleUILabelProductsListPrice {
	override func awakeFromNib() {
		super.awakeFromNib()
		
		applyStyles();
	}
	
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		applyStyles();
	}
	
	override func applyStyles() {
		super.applyStyles();
		
		textColor = AppColor.textSecondary;
		strikeThroughText();
	}
}

// MARK: - Screen General
class StyleUILabelScreenTitle: StyleUILabelBase {
	override func awakeFromNib() {
		super.awakeFromNib()
		
		applyStyles();
	}
	
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		applyStyles();
	}
	
	override func applyStyles() {
		super.applyStyles();
		
		font = TextStyle.h2.font;
	}
}

class StyleUILabelScreenSubtitle: StyleUILabelBase {
	override func awakeFromNib() {
		super.awakeFromNib()
		
		applyStyles();
	}
	
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		applyStyles();
	}
	
	override func applyStyles() {
		super.applyStyles();
		
		font = AppFont(size: TextStyle.subhead.fontSize, weight: .regular).font;
		textColor = AppColor.textSecondary;
	}
}

// MARK: - ProductDetails
class StyleUILabelProductDetailsPrice: StyleUILabelBase {
	override func awakeFromNib() {
		super.awakeFromNib()
		
		applyStyles();
	}
	
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		applyStyles();
	}
	
	override func applyStyles() {
		super.applyStyles();
		
		font = AppFont(size: !DeviceTrait.isLargeWindow ? 23 : 30, weight: .semibold).font;
	}
}

class StyleUILabelProductDetailsPriceDiscount: StyleUILabelBase {
	override func awakeFromNib() {
		super.awakeFromNib()
		
		applyStyles();
	}
	
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		applyStyles();
	}
	
	override func applyStyles() {
		super.applyStyles();
		
		font = AppFont(size: !DeviceTrait.isLargeWindow ? 16 : 22, weight: .regular).font;
		textColor = AppColor.textSecondary;
		strikeThroughText();
	}
}

// This class does not inherit StyleUILabelBase because it sets its own base style
// Font is set in HTML code for the label
class StyleUILabelProductDetailsDescription: UILabel {
	override func awakeFromNib() {
		super.awakeFromNib()
		
		applyStyles();
	}
	
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		applyStyles();
	}
	
	func applyStyles() {
		textColor = AppColor.textPrimary;
	}
}
