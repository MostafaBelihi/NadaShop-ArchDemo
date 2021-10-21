//
//  AppDelegate.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 21/04/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	
	static var dependencyRegistry: PDependencyRegistry!

	static var shared: AppDelegate {
		return UIApplication.shared.delegate as! AppDelegate;
	}

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Dependency Injection
		if (AppDelegate.dependencyRegistry == nil) {
			AppDelegate.dependencyRegistry = DependencyRegistry();
		}
		
		// Setup App Window
		let appManager = AppDelegate.dependencyRegistry.container.resolve(PAppManager.self)!;
		appManager.setupAppWindow();
		
		return true
	}

}

