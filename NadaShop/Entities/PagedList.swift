//
//  PagedList.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 13/09/2021.
//

import Foundation

struct PagedList<T> {
	var list: [T];
	var totalCount: Int?;
	var totalPages: Int?;
	var listParameters: ListParameters;
}
