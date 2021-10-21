//
//  BaseViewController.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 24/04/2021.
//

import UIKit

class ExtendedBaseViewController: BaseViewController {

	// MARK: - VC Events
    override func viewDidLoad() {
        super.viewDidLoad()

		// Nav Bar Back button
		if let navigationController = self.navigationController {
			if (navigationController.viewControllers.count > 1) {
//				setupBarBackButton();
			}
		}
    }
	
	// MARK: - Nav Bar Back Button
	func setupBarBackButton() {
		var btnBack: UIBarButtonItem!;
		btnBack = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(back(_:)));
		self.navigationItem.setLeftBarButtonItems([btnBack], animated: false);
	}
	
	@IBAction func back(_ sender: UIBarButtonItem) {
		navigationController?.popViewController(animated: true);
	}

}
