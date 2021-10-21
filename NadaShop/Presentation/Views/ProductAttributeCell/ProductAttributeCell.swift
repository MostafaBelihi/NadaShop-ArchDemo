//
//  ProductAttributeCell.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 09/10/2021.
//

import UIKit

class ProductAttributeCell: UITableViewCell {
	
	// MARK: - Dependencies
	private var presenter: PProductAttributeCellPresenter?
	
	// MARK: - Controls
	@IBOutlet weak var lblName: UILabel!
	@IBOutlet weak var picker: ItemPicker!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
}

//MARK: - Cell Config
extension ProductAttributeCell {
	public static var cellId: String {
		return "ProductAttributeCell"
	}
	
	public static var bundle: Bundle {
		return Bundle(for: ProductAttributeCell.self)
	}
	
	public static var nib: UINib {
		return UINib(nibName: ProductAttributeCell.cellId, bundle: ProductAttributeCell.bundle)
	}
	
	public static func register(with collectionView: UICollectionView) {
		collectionView.register(ProductAttributeCell.nib, forCellWithReuseIdentifier: ProductAttributeCell.cellId)
	}
	
	public static func loadFromNib(owner: Any?) -> ProductAttributeCell {
		return bundle.loadNibNamed(ProductAttributeCell.cellId, owner: owner, options: nil)?.first as! ProductAttributeCell
	}
	
	public static func dequeue(from tableView: UITableView, for indexPath: IndexPath, with presenter: PProductAttributeCellPresenter) -> ProductAttributeCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: ProductAttributeCell.cellId, for: indexPath) as! ProductAttributeCell;
		cell.config(with: presenter);
		return cell;
	}
	
	func config(with presenter: PProductAttributeCellPresenter) {
		self.presenter = presenter;
		
		// Set view data
		setData();
	}
	
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		// Re-set data when trait is changed
		setData();
	}
}

// MARK: - View
extension ProductAttributeCell {
	private func resetView() {
	}
	
	// Set data
	private func setData() {
		if let presenter = presenter {
			lblName.text = presenter.name;
			
			let colorPickerCellWidth = !DeviceTrait.isLargeWindow ? 30 : 35;
			let symbolPickerCellWidth = !DeviceTrait.isLargeWindow ? 40 : 45;
			let pickerCellHeight = !DeviceTrait.isLargeWindow ? 30 : 35;

			picker.setup(itemTexts: presenter.isColor ? .none : presenter.options.compactMap({ $0.name }),
						 itemColors: presenter.isColor ? presenter.options.compactMap({ AppColor.getColor(fromHex: $0.value) }) : .none,
						 itemTextFont: presenter.isColor ? .none : TextStyle.caption.font,
						 cellWidth: presenter.isColor ? colorPickerCellWidth : symbolPickerCellWidth,
						 cellHeight: pickerCellHeight,
						 itemBorderColor: .white,
						 itemBorderWidth: presenter.isColor ? 2.0 : 0,
						 itemCornerRadius: 7,
						 itemPadding: presenter.isColor ? 3.5 : 0,
						 itemTextColor: AppColor.textPrimary,
						 selectedBorderColor: presenter.isColor ? AppColor.tintPrimary : .none,
						 selectedBackgroundColor: presenter.isColor ? .none : AppColor.tintPrimary,
						 selectedTextColor: presenter.isColor ? .none : .white);
		}
	}
}
