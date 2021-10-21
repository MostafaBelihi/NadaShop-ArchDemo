//
//  ProductsListVC.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 30/04/2021.
//

import UIKit
import AlamofireImage

class ProductsListVC: ExtendedBaseViewController {
	// MARK: - Dependencies
	private var presenter: PProductsListPresenter!
	private var router: PProductRouter!
	private var alert: Alerting!
	private var di: PDependencyRegistry!
	
	// MARK: - Controls
	@IBOutlet weak var collectionView: UICollectionView!
	
	// MARK: - Variables
	
	// MARK: - Init
	init(presenter: PProductsListPresenter,
		 router: PProductRouter,
		 alert: Alerting,
		 di: PDependencyRegistry) {
		
		self.presenter = presenter;
		self.router = router;
		self.alert = alert;
		self.di = di;
		
		super.init(nibName: "ProductsListVC", bundle: nil);
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		
		alert.setParentView(as: self);
		presenter.delegate = self;

		setupCollectionView();

		showIndicator();
		presenter.fetchData();
    }

}

// MARK: - Data fetch completion
extension ProductsListVC: DataFetchCompletionDelegate {
	func onFetchCompleted(with newIndexes: [Int]?) {
		guard let newIndexes = newIndexes else {
			// First page
			hideIndicator();
			collectionView.reloadData();
			collectionView.isHidden = false;
			return;
		}
		
		// More pages
		let newIndexPaths = newIndexes.map { IndexPath(row: $0, section: 0) }
		collectionView.insertItems(at: newIndexPaths);
	}
	
	func onFetchFailed(with reason: String) {
		hideIndicator();
		alert.info(message: reason);
	}
}

// MARK: - CollectionView
// In order to fulfill dynamic view needs for different screen sizes, this collection view uses a custom layout inspired from this Stack Overflow answer:
// https://stackoverflow.com/a/51231881/7128177
extension ProductsListVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
	func setupCollectionView(){
		// Register CustomCell
		ProductCell.register(with: collectionView);
		SpinnerCell.register(with: collectionView);
		
		// Delegation
		collectionView.dataSource = self;
		collectionView.delegate = self;
		
		// Refresh
		let refreshControl = UIRefreshControl();
		refreshControl.addTarget(self, action:  #selector(reload), for: .valueChanged);
		refreshControl.tintColor = .gray;
		collectionView.refreshControl = refreshControl;

		// Attributes
		let layout = ProductsListCollectionViewFlowLayout();

		layout.sectionInsetReference = .fromContentInset;
		layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize;
		layout.minimumLineSpacing = AppSizes.ProductsList.rowSpacing;
		layout.minimumInteritemSpacing = AppSizes.ProductsList.columnSpacing;
		layout.sectionInset = UIEdgeInsets(top: AppSizes.ProductsList.sectionInsetTop,
										   left: AppSizes.ProductsList.sectionInsetLeft,
										   bottom: AppSizes.ProductsList.sectionInsetBottom,
										   right: AppSizes.ProductsList.sectionInsetRight);

		collectionView.collectionViewLayout = layout;
		collectionView.contentInsetAdjustmentBehavior = .always;
		collectionView.isHidden = true;
	}
	
	@objc func reload() {
		presenter.reset();
		presenter.fetchData();
		collectionView.refreshControl?.endRefreshing();
	}

	// numberOfSections
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1;
	}
	
	// numberOfRowsInSection
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		// Return one more cell for spinner cell
		return presenter.items.count + 1;
	}
	
	// View content in cell
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard presenter.items.count > 0 else {
			// Hide spinner cell for first load
			let cell = di.makeSpinnerCell(from: collectionView, for: indexPath);
			cell.config(isActive: false);
			return cell;
		}
		
		if isLoadingCell(for: indexPath) {
			// Spinner cell (one more cell)
			let cell = di.makeSpinnerCell(from: collectionView, for: indexPath);
			cell.config(isActive: (presenter.items.count < presenter.totalCount))
			return cell;
		}
		else {
			// Normal cell
			let item = presenter.items[indexPath.row];
			let cell = di.makeProductCell(from: collectionView, for: indexPath, with: item);
			return cell;
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if (indexPath.row < presenter.items.count) {
			router.viewProductDetails(for: presenter.items[indexPath.row].id, from: self);
		}
	}
	
	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		refetchData();
	}
	
	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		refetchData();
	}
}

private extension ProductsListVC {
	// Detect last cell (spinner cell) to fetch more data
	private func refetchData() {
		if (collectionView.indexPathsForVisibleItems.contains(where: isLoadingCell) && (presenter.items.count < presenter.totalCount)) {
			presenter.fetchData();
		}
	}
	
	// Detect spinner cell (if its index is more than data count)
	private func isLoadingCell(for indexPath: IndexPath) -> Bool {
		return (indexPath.row >= presenter.items.count);
	}
}

