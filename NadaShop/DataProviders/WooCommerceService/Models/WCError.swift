//
//  WCError.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 07/09/2021.
//

import Foundation

struct WCError: Codable {
	var code: String
	var message: String
	var data: WCErrorData
}

struct WCErrorData: Codable {
	var status: Int
}
