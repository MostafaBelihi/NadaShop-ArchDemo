//
//  iOS Project Infrastructure, by Mostafa AlBelliehy
//  Copyright © 2020 Mostafa AlBelliehy. All rights reserved.
//

import UIKit

class ErrorVC: UIViewController {
	@IBOutlet weak var lblError: UILabel!
	@IBOutlet weak var btnRetry: UIButton!
	
	var errorMessage = "";
	var actionButtonText = "";
	var action: () -> () = { return; };
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews();
		
		lblError.text = errorMessage;
		btnRetry.setTitle(actionButtonText, for: .normal);
	}
	
	@IBAction func didTapRetry(_ sender: Any) {
		action();
		removeFromParentVC();
	}
	
}
