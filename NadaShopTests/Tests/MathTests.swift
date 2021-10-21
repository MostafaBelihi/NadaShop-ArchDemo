//
//  MathTests.swift
//  NadaShopTests
//
//  Created by Mostafa AlBelliehy on 10/09/2021.
//

import XCTest
@testable import NadaShop

class MathTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

	func testFormatMoneyNumber() {
		// Given
		let number = Double(1000000);
		let number2 = Double(1);

		// When
		let formattedNumber1 = Math.formatMoneyNumber(number: number,
													 withThousandSeparators: true,
													 originalNumberFactor: .none,
													 newNumberFactor: .million,
													 currency: Currency.usd,
													 shouldGetCurrencySymbol: false);
		let formattedNumber2 = Math.formatMoneyNumber(number: number,
													  withThousandSeparators: true,
													  originalNumberFactor: .none,
													  newNumberFactor: .none,
													  currency: Currency.usd,
													  shouldGetCurrencySymbol: true);
		let formattedNumber3 = Math.formatMoneyNumber(number: number2,
													  withThousandSeparators: true,
													  originalNumberFactor: .million,
													  newNumberFactor: .none,
													  currency: Currency.usd,
													  shouldGetCurrencySymbol: true);

		// Then
		XCTAssertEqual(formattedNumber1, "1M USD");
		XCTAssertEqual(formattedNumber2, "$1,000,000");
		XCTAssertEqual(formattedNumber3, "$1,000,000");
	}
	
}
