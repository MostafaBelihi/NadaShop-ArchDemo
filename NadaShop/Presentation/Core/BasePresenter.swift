//
//  BasePresenter.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 16/09/2021.
//

import Foundation

class BasePresenter {

	var isFetching = false;
	
	func startFetching() {
		isFetching = true;
	}

	func endFetching() {
		isFetching = false;
	}
	
	init() {
		
	}

}
