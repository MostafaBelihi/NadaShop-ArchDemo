//
//  iOS Project Infrastructure, by Mostafa AlBelliehy
//  Copyright © 2020 Mostafa AlBelliehy. All rights reserved.
//

import Foundation

protocol ShowingError {
	func showError(message: String, actionButtonText: String?, action: @escaping ()->());
}
