//
//  iOS Project Infrastructure, by Mostafa AlBelliehy
//  Copyright © 2020 Mostafa AlBelliehy. All rights reserved.
//

import Foundation
import UIKit

protocol Logging {
	func info(_ items: Any...);
	func info(title: String, _ items: Any...);

	func debug(_ items: Any...);
	func debug(title: String, _ items: Any...);

	func error(_ items: Any...);
	func error(title: String, _ items: Any...);
}

class DebugLogger: Logging {
	init() {
	}
	
	func info(_ items: Any...) {
		log(title: "Info", items);
	}
	
	func info(title: String, _ items: Any...) {
		log(title: title, items);
	}

	func debug(_ items: Any...) {
		log(title: "Debug", items);
	}

	func debug(title: String, _ items: Any...) {
		log(title: title, items);
	}

	func error(_ items: Any...) {
		log(title: "Error", items);
	}

	func error(title: String, _ items: Any...) {
		log(title: title, items);
	}

	private func log(title: String, _ items: Any...) {
		let separator = "----------------------------------------------------------------------------------------";
		let titleSeparator = separator.prefix(title.count + 1);
		
		print(separator);
		print("\(title):");
		print(titleSeparator);
		print(items);
		print(separator);
	}
}
