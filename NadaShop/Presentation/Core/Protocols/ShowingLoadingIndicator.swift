//
//  iOS Project Infrastructure, by Mostafa AlBelliehy
//  Copyright © 2020 Mostafa AlBelliehy. All rights reserved.
//

import Foundation

protocol ShowingLoadingIndicator {
	// Shows the spinner
	func showIndicator(isFetchingData: Bool);
	
	// Hides the spinner
	func hideIndicator();
}
