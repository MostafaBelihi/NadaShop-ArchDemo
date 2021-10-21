//
//  iOS Project Infrastructure, by Mostafa AlBelliehy
//  Copyright © 2020 Mostafa AlBelliehy. All rights reserved.
//

import Foundation
import UIKit

protocol DismissingKeyboard {
	// Adds and configures the gesture that will be used to dismiss the keyboard
	func setupTapGesture();
	
	// The event handler called by the gesture
	func viewTapHandler(recognizer: UISwipeGestureRecognizer);
}
