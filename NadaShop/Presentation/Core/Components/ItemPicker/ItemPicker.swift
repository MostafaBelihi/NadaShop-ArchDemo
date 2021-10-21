//
//  ItemPicker.swift
//  Box-Training
//
//  Created by Mostafa AlBelliehy on 28/02/2019.
//  Copyright © 2019 Mostafa AlBelliehy. All rights reserved.
//

import UIKit

// TODO: Legacy Code:: Massive refactoring is required
class ItemPicker: UIView {
	private let contentXibName = "ItemPicker"
	@IBOutlet private var view: UIView!
	@IBOutlet private weak var collectionView: UICollectionView!
	
	// Data
	private var texts: [String]?;
	private var colors: [UIColor]?;
	private var count: Int = 0;
	private var selectedIndex: Int = 0;
	
	// Cell Properties
	private var _cellWidth: Int = 0;
	private var _cellHeight: Int = 0;
	private var _itemTextFont: UIFont?;
	private var _itemBorderColor: UIColor = UIColor.white;
	private var _itemContainerColor: UIColor = UIColor.white;		// TODO: This property is not used at all, but injected in setup() method
	private var _itemBorderWidth: CGFloat = 0;
	private var _itemCornerRadius: CGFloat = 0.0;
	private var _itemPadding: CGFloat = 0.0;
	private var _itemTextColor: UIColor = UIColor.black;
	private var _selectedBorderColor: UIColor?;
	private var _selectedBackgroundColor: UIColor?;
	private var _selectedTextColor: UIColor?;

	public func setup(itemTexts: [String]?,
					  itemColors: [UIColor]?,
					  itemTextFont: UIFont?,
					  cellWidth: Int = 0,
					  cellHeight: Int = 0,
					  itemBorderColor: UIColor = UIColor.white,
					  itemContainerColor: UIColor = UIColor.white,
					  itemBorderWidth: CGFloat = 0,
					  itemCornerRadius: CGFloat = 0.0,
					  itemPadding: CGFloat = 0.0,
					  itemTextColor: UIColor = UIColor.black,
					  selectedBorderColor: UIColor?,
					  selectedBackgroundColor: UIColor?,
					  selectedTextColor: UIColor?) {

		// Fetching Values
		if (itemTexts != nil) {
			texts = itemTexts;
		}
		if (itemColors != nil) {
			colors = itemColors;
		}
		
		_cellWidth = cellWidth;
		_cellHeight = cellHeight;
		_itemTextFont = itemTextFont;
		_itemBorderColor = itemBorderColor;
		_itemBorderWidth = itemBorderWidth;
		_itemCornerRadius = itemCornerRadius;
		_itemPadding = itemPadding;
		_itemTextColor = itemTextColor;
		_selectedBorderColor = selectedBorderColor;
		_selectedBackgroundColor = selectedBackgroundColor;
		_selectedTextColor = selectedTextColor;

		// DataSource
		if (texts != nil && colors != nil) {
			if (texts?.count == colors?.count) {
				
				count = (texts?.count)!;
				
			} else if ((texts?.count)! > (colors?.count)!) {
				
				count = (texts?.count)!;
				let fillCount = (texts?.count)! - (colors?.count)!;
				
				for _ in 0...fillCount - 1 {
					colors?.append(UIColor.white);
				}
				
			} else {
				
				count = (colors?.count)!;
				let fillCount = (colors?.count)! - (texts?.count)!;
				
				for _ in 0...fillCount - 1 {
					texts?.append("");
				}
				
			}
		} else if (texts != nil && colors == nil) {
			count = (texts?.count)!;
		} else if (texts == nil && colors != nil) {
			count = (colors?.count)!;
		} else {
			count = 0;
		}
		
		// CollectionView
		setupCollectionView();
		collectionView.reloadData();
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
	}
	
	private func commonInit() {
		Bundle.main.loadNibNamed(contentXibName, owner: self, options: nil);
		view.fixInView(self);
	}
}

// MARK: - CollectionView
extension ItemPicker : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	private func setupCollectionView(){
		// Register CustomCell
		collectionView.register(UINib(nibName: "ItemPickerCell", bundle: nil), forCellWithReuseIdentifier: "ItemPickerCell");
		
		// Delegation
		collectionView.dataSource = self;
		collectionView.delegate = self;
		
		// Attributes
	}
	
	// numberOfSections
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1;
	}
	
	// numberOfRowsInSection
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return count;
	}
	
	// View content in cell
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemPickerCell", for: indexPath) as! ItemPickerCell;

		if (texts != nil && colors != nil) {
			
			cell.setup(itemText: texts![indexPath.row],
					   itemColor: colors![indexPath.row],
					   itemTextFont: _itemTextFont,
					   cellWidth: _cellWidth,
					   cellHeight: _cellHeight,
					   itemBorderColor: _itemBorderColor,
					   itemBorderWidth: _itemBorderWidth,
					   itemCornerRadius: _itemCornerRadius,
					   itemPadding: _itemPadding,
					   itemTextColor: _itemTextColor,
					   selectedBorderColor: _selectedBorderColor,
					   selectedBackgroundColor: _selectedBackgroundColor,
					   selectedTextColor: _selectedTextColor,
					   isSelected: selectedIndex == indexPath.row);
						
		
		} else if (texts != nil && colors == nil) {
			
			cell.setup(itemText: texts![indexPath.row],
					   itemColor: nil,
					   itemTextFont: _itemTextFont,
					   cellWidth: _cellWidth,
					   cellHeight: _cellHeight,
					   itemBorderColor: _itemBorderColor,
					   itemBorderWidth: _itemBorderWidth,
					   itemCornerRadius: _itemCornerRadius,
					   itemPadding: _itemPadding,
					   itemTextColor: _itemTextColor,
					   selectedBorderColor: _selectedBorderColor,
					   selectedBackgroundColor: _selectedBackgroundColor,
					   selectedTextColor: _selectedTextColor,
					   isSelected: selectedIndex == indexPath.row);

		} else if (texts == nil && colors != nil) {
			
			cell.setup(itemText: nil,
					   itemColor: colors![indexPath.row],
					   itemTextFont: _itemTextFont,
					   cellWidth: _cellWidth,
					   cellHeight: _cellHeight,
					   itemBorderColor: _itemBorderColor,
					   itemBorderWidth: _itemBorderWidth,
					   itemCornerRadius: _itemCornerRadius,
					   itemPadding: _itemPadding,
					   itemTextColor: _itemTextColor,
					   selectedBorderColor: _selectedBorderColor,
					   selectedBackgroundColor: _selectedBackgroundColor,
					   selectedTextColor: _selectedTextColor,
					   isSelected: selectedIndex == indexPath.row);

		}

		return cell;
		
	}
	
	// Cell sizing
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: _cellWidth, height: _cellHeight);
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		selectedIndex = indexPath.row;
		collectionView.reloadData();
	}
}
