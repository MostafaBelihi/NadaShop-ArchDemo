//
//  iOS Project Infrastructure, by Mostafa AlBelliehy
//  Copyright © 2020 Mostafa AlBelliehy. All rights reserved.
//

import Foundation
import UIKit
import Swinject

protocol PAppManager {
	func setupAppWindow();
	func switchLanguage(via view: UIViewController?);
}

class AppManager: PAppManager {

	// MARK: - Dependencies
	private var logger: Logging;
	private var di: PDependencyRegistry;

	// MARK: - Init
	init(logger: Logging,
		 di: PDependencyRegistry) {
		
		// Dependencies
		self.logger = logger;
		self.di = di;
	}
	
	// MARK: - Functions
	/// Setup app window
	func setupAppWindow() {
		// Styles
		UITabBar.appearance().tintColor = AppColor.tintPrimary;
		UITabBar.appearance().barTintColor = AppColor.viewBackgroundPrimary;
		UINavigationBar.appearance().tintColor = AppColor.textPrimary;
		UINavigationBar.appearance().barTintColor = AppColor.viewBackgroundPrimary;

		// Get app main objects
		let appDelegate = UIApplication.shared.delegate as! AppDelegate;
		appDelegate.window?.rootViewController = nil;

		// Setup main view controller (It can be: UIViewController, UINavigationController, or UITabBarController)
		let rootViewController = di.makeRootViewController();

		// Setup app window
		appDelegate.window?.rootViewController = rootViewController;
		appDelegate.window?.resignKey();
		appDelegate.window?.makeKeyAndVisible();
	}

	/// Shows a view with languages to choose from.
	/// - Parameter view: The view or VC that calls this mehod, to present the switcher.
	func switchLanguage(via view: UIViewController?) {
		guard let view = view else {
			logger.error("No view was provided to present the language switcher!");
			return;
		}
		
		let languageSwitcher = di.makeLanguageSwitcher { () in self.setupAppWindow(); }
		view.present(languageSwitcher, animated: true, completion: nil);
	}
}
