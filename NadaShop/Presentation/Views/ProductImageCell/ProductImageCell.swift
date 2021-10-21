//
//  ProductImageCell.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 22/09/2021.
//

import UIKit

class ProductImageCell: UICollectionViewCell {
	
	// MARK: - Dependencies
	private var presenter: PProductImageCellPresenter!
	
	// MARK: - Controls
	@IBOutlet weak var image: UIImageView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
}

//MARK: - Cell Config
extension ProductImageCell {
	public static var cellId: String {
		return "ProductImageCell"
	}
	
	public static var bundle: Bundle {
		return Bundle(for: ProductImageCell.self)
	}
	
	public static var nib: UINib {
		return UINib(nibName: ProductImageCell.cellId, bundle: ProductImageCell.bundle)
	}
	
	public static func register(with collectionView: UICollectionView) {
		collectionView.register(ProductImageCell.nib, forCellWithReuseIdentifier: ProductImageCell.cellId)
	}
	
	public static func loadFromNib(owner: Any?) -> ProductImageCell {
		return bundle.loadNibNamed(ProductImageCell.cellId, owner: owner, options: nil)?.first as! ProductImageCell
	}
	
	public static func dequeue(from collectionView: UICollectionView, for indexPath: IndexPath, with presenter: PProductImageCellPresenter) -> ProductImageCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductImageCell.cellId, for: indexPath) as! ProductImageCell
		cell.config(with: presenter)
		return cell
	}
	
	func config(with presenter: PProductImageCellPresenter) {
		self.presenter = presenter;
		
		// Set view data
		setData();
	}
}

// MARK: - View
extension ProductImageCell {
	private func resetView() {
	}
	
	// Set data
	private func setData() {
		let placeholderImage = UIImage(named: ImageNames.productThumbnailPlaceholder.rawValue)!;
		
		if let imageURL = presenter.imageURL {
			image.af.setImage(withURL: imageURL, placeholderImage: placeholderImage, completion:  { [weak self] (response) in
				switch response.result {
					case .success(_):
						self?.image.contentMode = .scaleAspectFit;
						
					case .failure(_):
						self?.image.contentMode = .scaleAspectFill;
				}
			})
		}
	}
	
}
