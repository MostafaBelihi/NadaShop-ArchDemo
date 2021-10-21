//
//  BaseNetworkDataProviderFake.swift
//  NadaShopTests
//
//  Created by Mostafa AlBelliehy on 20/10/2021.
//

import Foundation
@testable import NadaShop

class BaseNetworkDataProviderFake {
	// MARK: - Dependencies
	var dataCoder: PDataCoder;
	var logger: Logging;
	
	
	// MARK: - Init
	init() {
		self.logger = DebugLogger();
		self.dataCoder = DataCoder(logger: logger);
	}
	
	// MARK: - Functions
	func translateNetworkFake<TTranslator: PTranslator>(from data: Data,
														networkModelType: TTranslator.TASource.Type,
														using translator: TTranslator) -> TTranslator.TADestination? where TTranslator.TASource : Decodable {
		
		guard let dataModel = dataCoder.decodeModel(ofType: networkModelType.self, from: data) else { return nil; }
		let translation = Translation(translator: translator);
		return translation.translate(from: dataModel);
	}

	func translateNetworkFake<TTranslator: PTranslator>(from data: Data,
														networkModelType: [TTranslator.TASource].Type,
														using translator: TTranslator) -> [TTranslator.TADestination]? where TTranslator.TASource : Decodable {
		
		guard let dataModel = dataCoder.decodeModel(ofType: networkModelType.self, from: data) else { return nil; }
		let translation = Translation(translator: translator);
		return translation.translate(from: dataModel);
	}
}
