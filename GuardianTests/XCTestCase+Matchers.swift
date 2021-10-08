//
//  XCTestCase+Matchers.swift
//  GuardianTests
//
//  Created by Tomasz Kuzma on 08/10/2021.
//

import Foundation
import XCTest

extension XCTestCase {
    func XCTAssertCount<T:Collection>(_ collection: T, _ number: Int) {
        XCTAssertEqual(collection.count, number)
    }
    func XCTAssertContains(_ testedString: String, _ expectedSubstring: String) {
        XCTAssertTrue(testedString.contains(expectedSubstring))
    }
}

