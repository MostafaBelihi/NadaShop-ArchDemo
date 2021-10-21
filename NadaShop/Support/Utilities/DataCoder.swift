//
//  DataCoder.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 10/09/2021.
//

import Foundation

protocol PDataCoder {
	func decodeModel<TModel: Decodable>(ofType modelTypp: TModel.Type, from data: Data) -> TModel?;
	func extractJSONData(jsonResource: String) -> Data?;
	func extractJSONData(from url: URL) -> Data?;
	func getData(from string: String) -> Data?;
	func getHTMLAttributedString(from htmlString: String) -> NSAttributedString?;
}

class DataCoder: PDataCoder {
	
	// MARK: - Dependencies
	private var logger: Logging;
	private var jsonDecoder: JSONDecoder;
	
	// MARK: - Init
	init(jsonDecoder: JSONDecoder? = nil, logger: Logging) {
		self.logger = logger;
		
		if let jsonDecoder =  jsonDecoder {
			self.jsonDecoder = jsonDecoder;
		}
		else {
			self.jsonDecoder = {
				let jsonDecoder = JSONDecoder();
				
				// Property casing
				jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase;
				
				// Date format
				let dateFormatter = DateFormatter();
				dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss";
				jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter);
				
				return jsonDecoder
			}();
		}
	}
	
	// MARK: - Functions
	func decodeModel<TModel: Decodable>(ofType modelType: TModel.Type, from data: Data) -> TModel? {
		do {
			let model = try self.jsonDecoder.decode(modelType.self, from: data);
			return model;
		}
		catch let ex {
			logger.error(title: "Exception", ex);
			return nil;
		}
	}
	
	func extractJSONData(jsonResource: String) -> Data? {
		let url = Bundle.main.url(forResource: jsonResource, withExtension: "json");
		
		if let url = url {
			do {
				let data = try Data(contentsOf: url);
				return data;
			}
			catch let ex {
				logger.error(title: "Exception", ex);
				return nil;
			}
		}
		else {
			return nil;
		}
	}
	
	func extractJSONData(from url: URL) -> Data? {
		do {
			let data = try Data(contentsOf: url);
			return data;
		}
		catch let ex {
			logger.error(title: "Exception", ex);
			return nil;
		}
	}
	
	func getData(from string: String) -> Data? {
		return string.data(using: .utf8);
	}
	
	func getHTMLAttributedString(from htmlString: String) -> NSAttributedString? {
		guard let data = getData(from: htmlString) else {
			return nil;
		}
		
		return try? NSAttributedString(data: data,
									   options: [.documentType: NSAttributedString.DocumentType.html],
									   documentAttributes: nil);
	}

}
