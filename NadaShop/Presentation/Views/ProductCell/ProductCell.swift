//
//  ProductCollectionViewCell.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 04/05/2021.
//

import UIKit

class ProductCell: UICollectionViewCell {

	// MARK: - Dependencies
	private var presenter: PProductCellPresenter!
	
	@IBOutlet weak var imageThumbnail: UIImageView!
	@IBOutlet weak var lblTitle: UILabel!
	@IBOutlet weak var lblDetails: UILabel!
	@IBOutlet weak var lblOriginalPrice: UILabel!
	@IBOutlet weak var lblPrice: UILabel!

	override func layoutSubviews() {
		super.layoutSubviews()
		
	}

	override func prepareForReuse() {
		super.prepareForReuse()
		
		resetView();
	}

}

//MARK: - Cell Config
extension ProductCell {
	public static var cellId: String {
		return "ProductCell"
	}
	
	public static var bundle: Bundle {
		return Bundle(for: ProductCell.self)
	}
	
	public static var nib: UINib {
		return UINib(nibName: ProductCell.cellId, bundle: ProductCell.bundle)
	}
	
	public static func register(with collectionView: UICollectionView) {
		collectionView.register(ProductCell.nib, forCellWithReuseIdentifier: ProductCell.cellId)
	}
	
	public static func loadFromNib(owner: Any?) -> ProductCell {
		return bundle.loadNibNamed(ProductCell.cellId, owner: owner, options: nil)?.first as! ProductCell
	}
	
	public static func dequeue(from collectionView: UICollectionView, for indexPath: IndexPath, with presenter: PProductCellPresenter) -> ProductCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.cellId, for: indexPath) as! ProductCell
		cell.config(with: presenter)
		return cell
	}

	func config(with presenter: PProductCellPresenter) {
		self.presenter = presenter;

		// Set view data
		setData();
	}
}

// MARK: - View
extension ProductCell {
	private func resetView() {
		let placeholderImage = UIImage(named: ImageNames.productThumbnailPlaceholder.rawValue)!;

		lblTitle.text = "";
		lblDetails.text = "";
		lblPrice.text = "";
		lblOriginalPrice.text = "";
		imageThumbnail.image = placeholderImage;

		lblOriginalPrice.isHidden = true;
		imageThumbnail.contentMode = .scaleAspectFill;
	}
	
	// Set data
	private func setData() {
		lblTitle.text = presenter.title;
		lblDetails.text = presenter.details;
		lblPrice.text = presenter.price;

		if let originalPrice = presenter.originalPrice {
			lblOriginalPrice.isHidden = false;
			lblOriginalPrice.text = originalPrice;
		}

		if let imageURL = presenter.thumbnailImage {
			let placeholderImage = UIImage(named: ImageNames.productThumbnailPlaceholder.rawValue)!;
			imageThumbnail.af.setImage(withURL: imageURL, placeholderImage: placeholderImage, completion:  { [weak self] (response) in
				switch response.result {
					case .success(_):
						self?.imageThumbnail.contentMode = .scaleAspectFit;
						
					case .failure(_):
						self?.imageThumbnail.contentMode = .scaleAspectFill;
				}
			})
		}
	}

}

// MARK: - CollectionView Layout
extension ProductCell {
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
