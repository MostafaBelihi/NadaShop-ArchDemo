//
//  WCListParameters.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 13/09/2021.
//

import Foundation

struct WCListParameters: Codable {
	var perPage: Int;
	var page: Int;
	var order: String;
	var orderBy: String;
}
