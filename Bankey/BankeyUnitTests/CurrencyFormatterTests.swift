//
//  CurrencyFormatterTests.swift
//  BankeyUnitTests
//
//  Created by Marco Carmona on 7/14/22.
//

import XCTest

@testable import Bankey

class Test: XCTestCase {
    let amount = 929466.23
    var formatter: CurrencyFormatter!
    
    override func setUp() {
        super.setUp()
        
        formatter = CurrencyFormatter()
    }
    
    func testShouldBeVisible() throws {
        let result = formatter.breakIntoDollarsAndCents(Decimal(amount))
        
        XCTAssertEqual(result.0, "929,466")
        XCTAssertEqual(result.1, "23")
    }
    
    func testDollarsFormatted() throws {
        let dollars = formatter.dollarsFormatted(amount)
        
        XCTAssertEqual(dollars, "$929,466.23")
    }
    
    func testZeroDollarsFormatted() throws {
        let dollars = formatter.dollarsFormatted(0)
        
        XCTAssertEqual(dollars, "$0.00")
    }
    
}
