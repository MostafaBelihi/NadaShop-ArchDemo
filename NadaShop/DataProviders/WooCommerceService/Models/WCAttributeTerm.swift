//
//  WCAttributeTerm.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 08/10/2021.
//

import Foundation

// MARK: - WCAttributeTerm
struct WCAttributeTerm: Codable {
	var id: Int
	var name: String
	var slug: String
	var description: String
	var menuOrder: Int
	var count: Int
}
