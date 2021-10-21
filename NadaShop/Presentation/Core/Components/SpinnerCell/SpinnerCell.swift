//
//  SpinnerCollectionViewCell.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 18/09/2021.
//

import UIKit

class SpinnerCell: UICollectionViewCell {
	
	@IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
		loadingIndicator.color = .gray;
		loadingIndicator.startAnimating();
		loadingIndicator.isHidden = false;
	}

}

//MARK: - Cell Config
extension SpinnerCell {
	public static var cellId: String {
		return "SpinnerCell"
	}
	
	public static var bundle: Bundle {
		return Bundle(for: SpinnerCell.self)
	}
	
	public static var nib: UINib {
		return UINib(nibName: SpinnerCell.cellId, bundle: SpinnerCell.bundle)
	}
	
	public static func register(with collectionView: UICollectionView) {
		collectionView.register(SpinnerCell.nib, forCellWithReuseIdentifier: SpinnerCell.cellId)
	}
	
	public static func loadFromNib(owner: Any?) -> SpinnerCell {
		return bundle.loadNibNamed(SpinnerCell.cellId, owner: owner, options: nil)?.first as! SpinnerCell
	}
	
	public static func dequeue(from collectionView: UICollectionView, for indexPath: IndexPath) -> SpinnerCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpinnerCell.cellId, for: indexPath) as! SpinnerCell
		return cell
	}
	
	func config(isActive: Bool = true) {
		loadingIndicator.isHidden = !isActive;
	}
}

// MARK: - CollectionView Layout
extension SpinnerCell {
	override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
		var columnsPerRow: CGFloat = 1;
		
		if (UIDevice.current.userInterfaceIdiom == .pad) {
			switch UIDevice.current.orientation {
				case .portrait, .portraitUpsideDown:
					columnsPerRow = 2;
					
				case .landscapeLeft, .landscapeRight:
					columnsPerRow = 3;
					
				default:
					columnsPerRow = 2;
			}
		}
		
		let targetSize = CGSize(width: (UIScreen.main.bounds.size.width - (AppSizes.ProductsList.sectionInsetLeft + AppSizes.ProductsList.sectionInsetRight) - (AppSizes.ProductsList.columnSpacing * columnsPerRow) - 1) / columnsPerRow,
								height: 0);
		layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel);
		
		return layoutAttributes;
	}
}
