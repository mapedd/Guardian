//
//  XCTestCase+Matchers.swift
//  GuardianTests
//
//  Created by Tomasz Kuzma on 08/10/2021.
//

import Foundation
import XCTest

extension XCTestCase {
    public func XCTAssertCount<T:Collection>(_ collection: T, _ number: Int) {
        XCTAssertEqual(collection.count, number)
    }
    public func XCTAssertContains(_ testedString: String, _ expectedSubstring: String) {
        XCTAssertTrue(testedString.contains(expectedSubstring))
    }
    public func XCTAssertURL(_ testedURL : URL, _ expectedAbsoluteString: String) {
        XCTAssertEqual(testedURL.absoluteString, expectedAbsoluteString)
    }
}

