//
//  SettingsVC.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 22/04/2021.
//

import UIKit

class SettingsVC: UIViewController {

	// MARK: - Dependencies
	private var presenter: PSettingsPresenter!
	private var appManager: PAppManager!

	// MARK: - Init
	init(presenter: PSettingsPresenter, appManager: PAppManager) {
		self.presenter = presenter;
		self.appManager = appManager;

		super.init(nibName: "SettingsVC", bundle: nil);
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
        super.viewDidLoad()
		
    }

	@IBAction func didTabSwitchLanguage(_ sender: Any) {
		DispatchQueue.main.async { [weak self] in
			self?.appManager.switchLanguage(via: self!);
		}
	}
	
}
