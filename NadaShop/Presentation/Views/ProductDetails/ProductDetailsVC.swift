//
//  ProductDetailsVC.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 26/08/2021.
//

import UIKit

class ProductDetailsVC: ExtendedBaseViewController {
	
	// MARK: - Dependencies
	private var presenter: PProductDetailsPresenter!
	private var router: PProductRouter!
	private var alert: Alerting!
	private var di: PDependencyRegistry!
	
	// MARK: - Data
	var id: Int;

	// MARK: - Controls
	@IBOutlet weak var viewContent: UIView!
	@IBOutlet weak var imageMain: UIImageView!
	@IBOutlet weak var constraintMainImage: NSLayoutConstraint!
	
	@IBOutlet weak var lblTitle: StyleUILabelScreenTitle!
	@IBOutlet weak var lblSubdetails: StyleUILabelScreenSubtitle!
	@IBOutlet weak var lblPrice: StyleUILabelProductDetailsPrice!
	@IBOutlet weak var lblOriginalPrice: StyleUILabelProductDetailsPriceDiscount!
	
	@IBOutlet weak var tableAttributes: UITableView!
	@IBOutlet weak var constraintTableAttributes: NSLayoutConstraint!
	let heightPerAttributeItem = 52;

	@IBOutlet weak var collectionImages: UICollectionView!
	@IBOutlet weak var lblDescription: StyleUILabelBase!
	@IBOutlet weak var constraintCollectionImages: NSLayoutConstraint!
	
	// MARK: - Init
	init(presenter: PProductDetailsPresenter,
		 router: PProductRouter,
		 alert: Alerting,
		 di: PDependencyRegistry,
		 productId: Int) {

		self.presenter = presenter;
		self.router = router;
		self.alert = alert;
		self.di = di;
		
		self.id = productId;

		super.init(nibName: "ProductDetailsVC", bundle: nil);
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func viewDidLoad() {
        super.viewDidLoad()

		viewContent.isHidden = true;
		showIndicator(isFetchingData: true);

		alert.setParentView(as: self);
		presenter.delegate = self;

		setupScrollView(contentView: viewContent);
		
		// Fetch data
		presenter.fetchData(id: self.id);

	}
	
	@IBAction func didTapNavImage(_ sender: Any) {
		if let mainImagePath = presenter.mainImagePath {
			router.viewProductImage(for: mainImagePath, from: self);
		}
	}
	
}

// MARK: - Data fetch completion
extension ProductDetailsVC: DataFetchCompletionDelegate {
	func onFetchCompleted(with newIndexes: [Int]?) {
		setData();
		
		viewContent.isHidden = false;
		hideIndicator();
	}
	
	func onFetchFailed(with reason: String) {
		hideIndicator();
		alert.info(message: reason);
	}
}

// MARK: - View
extension ProductDetailsVC {
	// Set data
	private func setData() {
		lblTitle.text = presenter.title;
		lblSubdetails.text = presenter.details;
		lblPrice.text = presenter.price;
		
		setDescription();
		
		if let originalPrice = presenter.originalPrice {
			lblOriginalPrice.isHidden = false;
			lblOriginalPrice.text = originalPrice;
		}
		
		if let mainImageURL = presenter.mainImageURL {
			imageMain.af.setImage(withURL: mainImageURL);
		}
		else {
			constraintMainImage.constant = 0;
		}

		if (presenter.images.count > 0) {
			setupCollectionView();
		}
		else {
			constraintCollectionImages.constant = 0;
		}
		
		if (presenter.images.count > 0) {
			setupTableView();
			constraintTableAttributes.constant = CGFloat(presenter.attributes.count * heightPerAttributeItem);
		}
		else {
			constraintTableAttributes.constant = 0;
		}
	}
	
	private func setDescription() {
		if let description = presenter.description {
			lblDescription.attributedText = description;
		}
	}
	
	// Re-setting some controls to responde to trait collection changes
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		if (!isFetchingData) {
			setDescription();
		}
	}
}

// MARK: - Images CollectionView
extension ProductDetailsVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	func setupCollectionView(){
		// Register CustomCell
		collectionImages.register(UINib(nibName: "ProductImageCell", bundle: nil), forCellWithReuseIdentifier: "ProductImageCell");
		
		// Delegation
		collectionImages.dataSource = self;
		collectionImages.delegate = self;
		
		// Attributes
		constraintCollectionImages.constant = !DeviceTrait.isPad ? 120 : 200;
	}
	
	// numberOfSections
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1;
	}
	
	// numberOfRowsInSection
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return presenter.images.count;
	}
	
	// View content in cell
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		// Get data item
		let item = presenter.images[indexPath.row];
		let cell = di.makeProductImageCell(from: collectionView, for: indexPath, with: item);
		return cell;
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		router.viewProductImage(for: presenter.images[indexPath.row].url, from: self);
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: !DeviceTrait.isPad ? 100 : 166, height: !DeviceTrait.isPad ? 120 : 200);
	}
}

// MARK: - Attributes TableView
extension ProductDetailsVC : UITableViewDataSource, UITableViewDelegate {
	func setupTableView(){
		// Register CustomCell
		tableAttributes.register(UINib(nibName: "ProductAttributeCell", bundle: nil), forCellReuseIdentifier: "ProductAttributeCell");
		
		// Delegation
		tableAttributes.dataSource = self;
		tableAttributes.delegate = self;
		
		// Attributes
		tableAttributes.tableFooterView = UIView();
		tableAttributes.estimatedRowHeight = 100;
		tableAttributes.rowHeight = UITableView.automaticDimension;
		tableAttributes.backgroundColor = .white;
	}
	
	// numberOfSections
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1;
	}
	
	// numberOfRowsInSection
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return presenter.attributes.count;
	}
	
	// View content in cell
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		// Get data item
		let item = presenter.attributes[indexPath.row];
		let cell = di.makeProductAttributeCell(from: tableView, for: indexPath, with: item);
		return cell;
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension;
	}
}

