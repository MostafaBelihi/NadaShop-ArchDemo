//
//  DependencyRegistry.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 20/08/2021.
//

import UIKit
import Swinject
import Reachability

protocol PDependencyRegistry {
	var container: Container { get };
	
	// MARK: - Maker Methods - Root and TabBar
	func makeRootViewController() -> UIViewController;
	func makeTabVC1() -> UIViewController;
	func makeTabVC2() -> UIViewController;
	func makeTabVC3() -> UIViewController;
	func makeTabVC4() -> UIViewController;
	
	// MARK: - Maker Methods - Specific
	func makeLanguageSwitcher(completion: @escaping VoidClosure) -> LanguageSwitcher;
	func makeSpinnerView(indicatorColor: UIColor?, backgroundColor: UIColor?) -> SpinnerView;
	func makeSpinnerCell(from collectionView: UICollectionView, for indexPath: IndexPath) -> SpinnerCell;
	func makeProductsListVC() -> ProductsListVC;
	func makeProductDetailsVC(with productId: Int) -> ProductDetailsVC;
	func makeProductImageVC(with imagePath: String) -> ProductImageVC;
	func makeOrdersListVC() -> OrdersListVC;
	func makeSearchVC() -> SearchVC;
	func makeSettingsVC() -> SettingsVC;
	func makeProductCell(from collectionView: UICollectionView, for indexPath: IndexPath, with item: Product) -> ProductCell;
	func makeProductImageCell(from collectionView: UICollectionView, for indexPath: IndexPath, with item: Image) -> ProductImageCell;
	func makeProductAttributeCell(from tableView: UITableView, for indexPath: IndexPath, with item: Attribute) -> ProductAttributeCell;
}

class DependencyRegistry: PDependencyRegistry {
	
	var container: Container;
	
	// MARK: - Init
	init() {
		container = Container();
		Container.loggingFunction = nil;
		
		// Register Dependencies
		registerSupport();
		registerDataProviders();
		registerInteractors();
		registerRouters();
		registerPresenters();
		registerViews();
	}
	
	// MARK: - Supportive Layer
	private func registerSupport() {
		container.register(MonitoringConnection.self) { r in
			let instance = ConnectionManager();
			instance.setup(reachability: try! Reachability());
			
			return instance;
		}.inObjectScope(.container);
		
		container.register(Logging.self) { _ in DebugLogger() }.inObjectScope(.container);
		
		container.register(PDataCoder.self) { r in DataCoder(logger: r.resolve(Logging.self)!) }.inObjectScope(.container);
	}
	
	// MARK: - Data Providers
	private func registerDataProviders() {
		container.register(PProductNetworkDataProvider.self) { r in
			ProductNetworkDataProvider(logger: r.resolve(Logging.self)!, dataCoder: r.resolve(PDataCoder.self)!)
		}.inObjectScope(.container);
		
		container.register(PAttributeNetworkDataProvider.self) { r in
			AttributeNetworkDataProvider(logger: r.resolve(Logging.self)!, dataCoder: r.resolve(PDataCoder.self)!)
		}.inObjectScope(.container);
	}
	
	// MARK: - Interactors
	private func registerInteractors() {
		container.register(PProductInteractor.self) { r in
			ProductInteractor(productNetworkDataProvider: r.resolve(PProductNetworkDataProvider.self)!,
							  attributeNetworkDataProvider: r.resolve(PAttributeNetworkDataProvider.self)!,
							  logger: r.resolve(Logging.self)!)
		}.inObjectScope(.container);
	}
	
	// MARK: - Routers
	private func registerRouters() {
		container.register(PProductRouter.self) { _ in ProductRouter(di: self) }
	}
	
	// MARK: - Presenters
	private func registerPresenters() {
		container.register(PProductCellPresenter.self) { (_, item: Product) in ProductCellPresenter(with: item) }
		container.register(PProductImageCellPresenter.self) { (_, item: Image) in ProductImageCellPresenter(with: item) }
		container.register(PProductAttributeCellPresenter.self) { (_, item: Attribute) in ProductAttributeCellPresenter(with: item) }
		container.register(PProductImagePresenter.self) { (_, imagePath: String) in ProductImagePresenter(with: imagePath) }

		container.register(PProductsListPresenter.self) { r in ProductsListPresenter(productInteractor: r.resolve(PProductInteractor.self)!) }
		container.register(PProductDetailsPresenter.self) { r in
			ProductDetailsPresenter(productInteractor: r.resolve(PProductInteractor.self)!,
									dataCoder: r.resolve(PDataCoder.self)!)
		}

		container.register(POrdersListPresenter.self) { _ in OrdersListPresenter() }
		container.register(PSearchPresenter.self) { _ in SearchPresenter() }
		container.register(PSettingsPresenter.self) { _ in SettingsPresenter() }
	}
	
	// MARK: - Views
	private func registerViews() {
		// AppManager
		container.register(PAppManager.self) { r in
			AppManager(logger: r.resolve(Logging.self)!,
					   di: self)
		}.inObjectScope(.container);
		
		// Supportive Views
		container.register(Alerting.self) { _ in Alert() }
		
		container.register(LanguageSwitcher.self) { (r, completion: @escaping VoidClosure) in
			let instance = LanguageSwitcher();
			instance.config(completed: completion);
			
			return instance;
		}
		
		container.register(SpinnerView.self) { _ in SpinnerView() };
		
		// View Controllers
		container.register(ProductsListVC.self) { r in
			ProductsListVC(presenter: r.resolve(PProductsListPresenter.self)!,
						   router: r.resolve(PProductRouter.self)!,
						   alert: r.resolve(Alerting.self)!,
						   di: self)
		}
		
		container.register(ProductDetailsVC.self) { (r, productId: Int) in
			ProductDetailsVC(presenter: r.resolve(PProductDetailsPresenter.self)!,
							 router: r.resolve(PProductRouter.self)!,
							 alert: r.resolve(Alerting.self)!,
							 di: self,
							 productId: productId)
		}
		
		container.register(ProductImageVC.self) { (r, imagePath: String) in
			ProductImageVC(presenter: r.resolve(PProductImagePresenter.self, argument: imagePath)!,
						   alert: r.resolve(Alerting.self)!,
						   di: self)
		}
		
		container.register(OrdersListVC.self) { r in
			OrdersListVC(presenter: r.resolve(POrdersListPresenter.self)!)
		}
		
		container.register(SearchVC.self) { r in
			SearchVC(presenter: r.resolve(PSearchPresenter.self)!)
		}
		
		container.register(SettingsVC.self) { r in
			SettingsVC(presenter: r.resolve(PSettingsPresenter.self)!,
					   appManager: r.resolve(PAppManager.self)!)
		}
		
		container.register(TabBarController.self) { _ in TabBarController() }
	}
	
	// MARK: - Maker Methods - Root and TabBar
	func makeRootViewController() -> UIViewController {
		return container.resolve(TabBarController.self)!;
	}
	
	func makeTabVC1() -> UIViewController {
		return makeProductsListVC();
	}
	
	func makeTabVC2() -> UIViewController {
		return makeSearchVC();
	}
	
	func makeTabVC3() -> UIViewController {
		return makeOrdersListVC();
	}
	
	func makeTabVC4() -> UIViewController {
		return makeSettingsVC();
	}
	
	// MARK: - Maker Methods - Specific
	func makeLanguageSwitcher(completion: @escaping VoidClosure) -> LanguageSwitcher {
		return container.resolve(LanguageSwitcher.self, argument: completion)!;
	}
	
	func makeSpinnerView(indicatorColor: UIColor?, backgroundColor: UIColor?) -> SpinnerView {
		let vc = container.resolve(SpinnerView.self)!;
		vc.config(indicatorColor: indicatorColor, backgroundColor: backgroundColor);
		return vc;
	}
	
	func makeSpinnerCell(from collectionView: UICollectionView, for indexPath: IndexPath) -> SpinnerCell {
		let cell = SpinnerCell.dequeue(from: collectionView, for: indexPath);
		return cell;
	}
	
	func makeProductsListVC() -> ProductsListVC {
		return container.resolve(ProductsListVC.self)!;
	}
	
	func makeProductDetailsVC(with productId: Int) -> ProductDetailsVC {
		return container.resolve(ProductDetailsVC.self, argument: productId)!;
	}
	
	func makeProductImageVC(with imagePath: String) -> ProductImageVC {
		return container.resolve(ProductImageVC.self, argument: imagePath)!;
	}
	
	func makeOrdersListVC() -> OrdersListVC {
		return container.resolve(OrdersListVC.self)!;
	}
	
	func makeSearchVC() -> SearchVC {
		return container.resolve(SearchVC.self)!;
	}
	
	func makeSettingsVC() -> SettingsVC {
		return container.resolve(SettingsVC.self)!;
	}
	
	func makeProductCell(from collectionView: UICollectionView, for indexPath: IndexPath, with item: Product) -> ProductCell {
		let presenter = container.resolve(PProductCellPresenter.self, argument: item)!;
		let cell = ProductCell.dequeue(from: collectionView, for: indexPath, with: presenter);
		return cell;
	}
	
	func makeProductImageCell(from collectionView: UICollectionView, for indexPath: IndexPath, with item: Image) -> ProductImageCell {
		let presenter = container.resolve(PProductImageCellPresenter.self, argument: item)!;
		let cell = ProductImageCell.dequeue(from: collectionView, for: indexPath, with: presenter);
		return cell;
	}
	
	func makeProductAttributeCell(from tableView: UITableView, for indexPath: IndexPath, with item: Attribute) -> ProductAttributeCell {
		let presenter = container.resolve(PProductAttributeCellPresenter.self, argument: item)!;
		let cell = ProductAttributeCell.dequeue(from: tableView, for: indexPath, with: presenter);
		return cell;
	}
}
