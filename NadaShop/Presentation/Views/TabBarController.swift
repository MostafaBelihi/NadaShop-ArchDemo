//
//  TabBarController.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 22/04/2021.
//

import UIKit

class TabBarController: UITabBarController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		/// Insert VCs into TabBarController
		// Home
		let vc1 = AppDelegate.dependencyRegistry.makeTabVC1();
		vc1.title = NSLocalizedString("products", comment: "");
		vc1.tabBarItem = UITabBarItem(title: NSLocalizedString("home", comment: ""), image: ViewConstants.homeTabBarImage, selectedImage: ViewConstants.homeTabBarImage);		// attach to TabBarItem
		let vc1Nav = UINavigationController(rootViewController: vc1);		// embed in NavigationController
		
		// Search
		let vc2 = AppDelegate.dependencyRegistry.makeTabVC2();
		vc2.title = NSLocalizedString("search", comment: "");
		vc2.tabBarItem = UITabBarItem(title: NSLocalizedString("search", comment: ""), image: ViewConstants.searchTabBarImage, selectedImage: ViewConstants.searchTabBarImage);		// attach to TabBarItem
		let vc2Nav = UINavigationController(rootViewController: vc2);		// embed in NavigationController
		
		// Orders
		let vc3 = AppDelegate.dependencyRegistry.makeTabVC3();
		vc3.title = NSLocalizedString("orders", comment: "");
		vc3.tabBarItem = UITabBarItem(title: NSLocalizedString("orders", comment: ""), image: ViewConstants.ordersTabBarImage, selectedImage: ViewConstants.ordersTabBarImage);		// attach to TabBarItem
		let vc3Nav = UINavigationController(rootViewController: vc3);		// embed in NavigationController
		
		// Settings
		let vc4 = AppDelegate.dependencyRegistry.makeTabVC4();
		vc4.title = NSLocalizedString("settings", comment: "");
		vc4.tabBarItem = UITabBarItem(title: NSLocalizedString("settings", comment: ""), image: ViewConstants.settingsTabBarImage, selectedImage: ViewConstants.settingsTabBarImage);		// attach to TabBarItem
		let vc4Nav = UINavigationController(rootViewController: vc4);		// embed in NavigationController

		// Add to TabBarController
		let controllers = [vc1Nav, vc2Nav, vc3Nav, vc4Nav];
		self.viewControllers = controllers;
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
}
