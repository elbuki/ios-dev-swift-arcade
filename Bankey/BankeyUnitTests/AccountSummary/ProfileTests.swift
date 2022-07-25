//
//  ProfileTests.swift
//  BankeyUnitTests
//
//  Created by Marco Carmona on 7/21/22.
//

@testable import Bankey
import XCTest

class ProfileTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testCanParse() throws {
        let json = """
            {
                "id": "1",
                "first_name": "Kevin",
                "last_name": "Flynn",
            }
        """
        
        guard let data = json.data(using: .utf8) else {
            fatalError("Could not convert json to data")
        }
        
        let result = try! JSONDecoder().decode(Profile.self, from: data)
        
        XCTAssertEqual(result.id, "1")
        XCTAssertEqual(result.firstName, "Kevin")
        XCTAssertEqual(result.lastName, "Flynn")
    }
    
}
