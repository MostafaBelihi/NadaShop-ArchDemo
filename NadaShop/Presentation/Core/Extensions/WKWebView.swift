//
//  WKWebView.swift
//  My-Stocks
//
//  Created by Mostafa AlBelliehy on 04/12/2020.
//  Copyright © 2020 Mostafa AlBelliehy. All rights reserved.
//

import Foundation
import WebKit

extension WKWebView {
	func load(_ urlString: String) {
		if let url = URL(string: urlString) {
			let request = URLRequest(url: url)
			load(request)
		}
	}
}
