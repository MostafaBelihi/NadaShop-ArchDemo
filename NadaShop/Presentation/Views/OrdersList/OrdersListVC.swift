//
//  OrdersListVC.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 22/04/2021.
//

import UIKit

class OrdersListVC: ExtendedBaseViewController {

	// MARK: - Dependencies
	private var presenter: POrdersListPresenter!
	
	// MARK: - Init
	init(presenter: POrdersListPresenter) {
		self.presenter = presenter;
		
		super.init(nibName: "OrdersListVC", bundle: nil);
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		
    }

}
