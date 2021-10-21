//
//  iOS Project Infrastructure, by Mostafa AlBelliehy
//  Copyright © 2020 Mostafa AlBelliehy. All rights reserved.
//

import Foundation
import UIKit

struct ViewConstants {
	static let homeTabBarImage = UIImage(named: "home");
	static let searchTabBarImage = UIImage(named: "search");
	static let ordersTabBarImage = UIImage(named: "order");
	static let settingsTabBarImage = UIImage(named: "profile");
	
	static let defaultListParameters =
		ListParameters(pageSize: 10,
					   page: 1,
					   sortBy: "",
					   sort: "desc");
}
