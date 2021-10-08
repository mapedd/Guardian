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
}
