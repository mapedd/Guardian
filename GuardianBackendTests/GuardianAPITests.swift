//
//  GuardianAPITests.swift
//  GuardianBackendTests
//
//  Created by Tomasz Kuzma on 06/10/2021.
//

import XCTest
import Combine
import GuardianBackend

class GuardianAPITests: XCTestCase {

    func testAPIReturnsValidData() throws {
        let apiProvider = MockAPIProvider()
        let api = GuardianAPI(apiProvider: apiProvider)
        let recipes = try wait(for:api.recipes())
        let expectedItems = [
            ["id" : "id0"],
            ["id" : "id1"]
        ]
        let result = recipes.response.results.map {
            return ["id" : $0.id]
        }
        XCTAssertEqual(result, expectedItems)
    }

    func testAPIReturnsErrorMappedFromURLError() throws {
        let apiProvider = MockAPIProvider(returnError: true)
        let api = GuardianAPI(apiProvider: apiProvider)
        let errorReceived = try waitFailure(for: api.recipes())
        let expectedError = GuardianAPI.Error.unreachable(GuardianAPI.EndPoint.recipes.url)
        XCTAssertEqual(errorReceived, expectedError)
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

