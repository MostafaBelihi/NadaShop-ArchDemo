//
//  Translation.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 16/08/2021.
//

import Foundation

protocol PTranslation {
	associatedtype TTranslator: PTranslator;
	func translate(from item: TTranslator.TASource) -> TTranslator.TADestination;
	func translate(from items: [TTranslator.TASource]) -> [TTranslator.TADestination];
}

class Translation<TTranslator: PTranslator>: PTranslation {
	// MARK: - Dependencies
	private var translator: TTranslator;
	
	// MARK: - Init
	init(translator: TTranslator) {
		self.translator = translator;
	}
	
	// MARK: - Functions
	func translate(from item: TTranslator.TASource) -> TTranslator.TADestination {
		return translator.translate(from: item);
	}

	func translate(from items: [TTranslator.TASource]) -> [TTranslator.TADestination] {
		return items.compactMap({ translator.translate(from: $0) });
	}
}
