//
//  DataFetchCompletionDelegate.swift
//  NadaShop
//
//  Created by Mostafa AlBelliehy on 22/09/2021.
//

import Foundation

protocol DataFetchCompletionDelegate: AnyObject {
	func onFetchCompleted(with newIndexes: [Int]?);
	func onFetchFailed(with reason: String);
}
