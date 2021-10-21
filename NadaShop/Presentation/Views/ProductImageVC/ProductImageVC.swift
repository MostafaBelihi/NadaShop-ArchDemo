//
//  ProductImageVC.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 10/10/2021.
//

import UIKit

class ProductImageVC: BaseViewController {

	// MARK: - Dependencies
	private var presenter: PProductImagePresenter!
	private var alert: Alerting!
	private var di: PDependencyRegistry!
	
	// MARK: - Controls
	@IBOutlet weak var viewImage: PanZoomImageView!
	
	// MARK: - Init
	init(presenter: PProductImagePresenter,
		 alert: Alerting,
		 di: PDependencyRegistry) {
		
		self.presenter = presenter;
		self.alert = alert;
		self.di = di;
		
		super.init(nibName: "ProductImageVC", bundle: nil);
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()

		alert.setParentView(as: self);
		
		setData();
    }

	@IBAction func didTapDismiss(_ sender: Any) {
		dismiss(animated: true);
	}
}

// MARK: - View
extension ProductImageVC {
	// Set data
	private func setData() {
		let placeholderImage = UIImage(named: ImageNames.productThumbnailPlaceholder.rawValue)!;
		
		showIndicator();
		if let imageURL = presenter.imageURL {
			viewImage.imageView.af.setImage(withURL: imageURL, placeholderImage: placeholderImage, completion:  { (response) in
				switch response.result {
					case .success(_):
						self.viewImage.imageView.contentMode = .scaleAspectFit;
						self.hideIndicator();
						
					case .failure(_):
						self.viewImage.imageView.contentMode = .scaleAspectFill;
						self.hideIndicator();
				}
			})
		}
	}
}
