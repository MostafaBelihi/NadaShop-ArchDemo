//
//  iOS Project Infrastructure, by Mostafa AlBelliehy
//  Copyright © 2020 Mostafa AlBelliehy. All rights reserved.
//

import Foundation
import UIKit

protocol Alerting {
	func setParentView(as parentView: UIViewController);
	func info(message: String);
	func confirm(_ message: String, handler: @escaping (UIAlertAction)->());
	func error(_ message: String, actionButtonText: String, handler: @escaping (UIAlertAction)->());
}

class Alert: Alerting {
	// MARK: - Dependencies
	private var parentView: UIViewController?;
	
	// MARK: - Init
	init () {
	}
	
	func setParentView(as parentView: UIViewController) {
		self.parentView = parentView;
	}
	
	// MARK: - Functions
	func info(message: String) {
		guard let parentView = self.parentView else {
			// TODO: Use logger
			print("Parent view not set!");
			return;
		}
		
		let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert);
		
		alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default, handler: nil));
		
		parentView.present(alert, animated: true);
	}
	
	func confirm(_ message: String, handler: @escaping (UIAlertAction)->()) {
		guard let parentView = self.parentView else {
			// TODO: Use logger
			print("Parent view not set!");
			return;
		}
		
		let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert);
		
		alert.addAction(UIAlertAction(title: NSLocalizedString("yes", comment: ""), style: .default, handler: handler));
		alert.addAction(UIAlertAction(title: NSLocalizedString("no", comment: ""), style: .default, handler: nil));
		
		parentView.present(alert, animated: true);
	}
	
	func error(_ message: String, actionButtonText: String, handler: @escaping (UIAlertAction)->()) {
		guard let parentView = self.parentView else {
			// TODO: Use logger
			print("Parent view not set!");
			return;
		}
		
		let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert);
		
		alert.addAction(UIAlertAction(title: actionButtonText, style: .default, handler: handler));
		alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default, handler: nil));
		
		parentView.present(alert, animated: true);
	}
	
}
