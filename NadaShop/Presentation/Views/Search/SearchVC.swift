//
//  SearchVC.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 22/04/2021.
//

import UIKit

class SearchVC: UIViewController {

	// MARK: - Dependencies
	private var presenter: PSearchPresenter!
	
	// MARK: - Init
	init(presenter: PSearchPresenter) {
		self.presenter = presenter;
		
		super.init(nibName: "SearchVC", bundle: nil);
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
        super.viewDidLoad()

    }


}
