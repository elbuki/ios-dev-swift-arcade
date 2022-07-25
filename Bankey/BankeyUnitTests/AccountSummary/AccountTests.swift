//
//  AccountTests.swift
//  BankeyUnitTests
//
//  Created by Marco Carmona on 7/25/22.
//

import Foundation

@testable import Bankey
import XCTest

class AccountTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    func testCanParse() throws {
        let json = """
            [
                {
                    "id": "1",
                    "type": "Banking",
                    "name": "Basic Savings",
                    "amount": 929466.23,
                    "createdDateTime": "2010-06-21T15:29:32Z"
                },
                {
                    "id": "2",
                    "type": "Banking",
                    "name": "No-Fee All-In Chequing",
                    "amount": 17562.44,
                    "createdDateTime": "2011-06-21T15:29:32Z"
                }
            ]
        """
        let decodedData = [
            Account(
                id: "1",
                type: .banking,
                name: "Basic Savings",
                amount: 929466.23,
                createdDateTime: try! Date.init("2010-06-21T15:29:32Z", strategy: .iso8601)
            ),
            Account(
                id: "2",
                type: .banking,
                name: "No-Fee All-In Chequing",
                amount: 17562.44,
                createdDateTime: try! Date.init("2011-06-21T15:29:32Z", strategy: .iso8601)
            ),
        ]
        
        let decoder = JSONDecoder()
        
        decoder.dateDecodingStrategy = .iso8601
        
        guard let data = json.data(using: .utf8) else {
            fatalError("Could not convert json to data")
        }
        
        let result = try! decoder.decode([Account].self, from: data)
        
        for index in 0..<result.count {
            let expected = decodedData[index]
            let actual = result[index]
            
            XCTAssertEqual(expected.id, actual.id)
            XCTAssertEqual(expected.type, actual.type)
            XCTAssertEqual(expected.name, actual.name)
            XCTAssertEqual(expected.amount, actual.amount)
            XCTAssertEqual(expected.createdDateTime, actual.createdDateTime)
        }
    }
}
