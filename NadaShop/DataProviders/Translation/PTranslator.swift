//
//  PTranslator.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 05/09/2021.
//

// Workaround to inject protocols with associatedtype: https://github.com/Swinject/Swinject/issues/223#issuecomment-399476115

import Foundation

protocol PTranslator {
	associatedtype TSource;
	associatedtype TDestination;
	
	typealias TASource = TSource;
	typealias TADestination = TDestination;

	func translate(from model: TSource) -> TDestination;
}
