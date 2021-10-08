//
//  GuardianAPITests.swift
//  GuardianTests
//
//  Created by Tomasz Kuzma on 06/10/2021.
//

import XCTest
@testable import Guardian
import Combine


class GuardianAPITests: XCTestCase {

    func testAPIReturnsEmptyDataViaNetwork() throws {
        let apiProvider = MockAPIProvider()
        let api = GuardianAPI(apiProvider: apiProvider)
        let recipes = try wait(for:api.recipes())
        let expected = GuardianResponse(response: RecipeResponse(results: []))
        XCTAssertEqual(recipes, expected)
    }

    func testAPICallsCorrectURL() throws {
        let apiProvider = MockAPIProvider()
        let api = GuardianAPI(apiProvider: apiProvider)
        let _ = try wait(for:api.recipes())
        XCTAssertCount(apiProvider.urlsInserted, 1)
        let url = try XCTUnwrap(apiProvider.urlsInserted.first)
        XCTAssertContains(url.absoluteString, "https://content.guardianapis.com/search")
    }
}

