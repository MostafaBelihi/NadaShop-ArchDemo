//
//  ItemPickerCell.swift
//  Box-Training
//
//  Created by Mostafa AlBelliehy on 28/02/2019.
//  Copyright © 2019 Mostafa AlBelliehy. All rights reserved.
//

import UIKit

class ItemPickerCell: UICollectionViewCell {
	// Controls
	@IBOutlet private weak var viewCellMainView: UIView!
	@IBOutlet private weak var viewContent: UIView!
	@IBOutlet private weak var lblText: UILabel!
	
	// Constraints
	@IBOutlet weak var constraintLeadingPadding: NSLayoutConstraint!
	@IBOutlet weak var constraintBottomPadding: NSLayoutConstraint!
	@IBOutlet weak var constraintTrailingPadding: NSLayoutConstraint!
	@IBOutlet weak var constraintTopPadding: NSLayoutConstraint!
	
	public func setup(itemText: String?,
					  itemColor: UIColor?,
					  itemTextFont: UIFont?,
					  cellWidth: Int = 0,
					  cellHeight: Int = 0,
					  itemBorderColor: UIColor = UIColor.white,
					  itemBorderWidth: CGFloat = 0,
					  itemCornerRadius: CGFloat = 0.0,
					  itemPadding: CGFloat = 0.0,
					  itemTextColor: UIColor = UIColor.black,
					  containerBackgroundColor: UIColor = UIColor.white,
					  selectedBorderColor: UIColor?,
					  selectedBackgroundColor: UIColor?,
					  selectedTextColor: UIColor?,
					  isSelected: Bool = false) {

		let contentWidth = CGFloat(cellWidth) - (itemPadding * 2);
		let contentHeight = CGFloat(cellHeight) - (itemPadding * 2);

		viewCellMainView.bounds.size = CGSize(width: cellWidth, height: cellHeight);
		viewContent.bounds.size = CGSize(width: contentWidth, height: contentHeight);
		
		if let sBorderColor = selectedBorderColor {
			viewCellMainView.layer.borderColor = isSelected ? sBorderColor.cgColor : itemBorderColor.cgColor;
		} else {
			viewCellMainView.layer.borderColor = itemBorderColor.cgColor;
		}
		
		viewCellMainView.layer.borderWidth = itemBorderWidth;
		
		viewCellMainView.layer.cornerRadius = itemCornerRadius;
		viewContent.layer.cornerRadius = contentHeight * (itemCornerRadius / CGFloat(cellHeight));
		
		constraintLeadingPadding.constant = itemPadding;
		constraintTopPadding.constant = itemPadding;
		constraintTrailingPadding.constant = itemPadding;
		constraintBottomPadding.constant = itemPadding;
		
		if let sTextColor = selectedTextColor {
			lblText.textColor = isSelected ? sTextColor : itemTextColor;
		} else {
			lblText.textColor = itemTextColor;
		}

		if let textFont = itemTextFont {
			lblText.font = textFont;
		}
		
		// Data
		if let sBackgroundColor = selectedBackgroundColor {
			if let color = itemColor {
				viewContent.backgroundColor = isSelected ? sBackgroundColor : color;
			} else {
				viewContent.backgroundColor = isSelected ? sBackgroundColor : containerBackgroundColor;
			}
		} else {
			if let color = itemColor {
				viewContent.backgroundColor = color;
			} else {
				viewContent.backgroundColor = containerBackgroundColor;
			}
		}
		
		if let text = itemText {
			lblText.text = text;
		}
		
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
		
		viewCellMainView.clipsToBounds = true;
		lblText.textAlignment = .center;
		
    }

}
