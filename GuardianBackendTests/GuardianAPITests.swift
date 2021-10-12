//
//  GuardianAPITests.swift
//  GuardianBackendTests
//
//  Created by Tomasz Kuzma on 06/10/2021.
//

import XCTest
import Combine
import GuardianBackend
import TestingExtensions

class GuardianAPITests: XCTestCase {

    func testAPIReturnsValidData() throws {
        let apiProvider = MockAPIProvider()
        let api = GuardianAPI(apiProvider: apiProvider,
                              endpoint: EndPoint.search(filters: []))
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
        let endPoint = EndPoint.search(filters: [])
        let apiProvider = MockAPIProvider(returnError: true)
        let api = GuardianAPI(apiProvider: apiProvider,
                              endpoint: endPoint)
        let errorReceived = try waitFailure(for: api.recipes())
        
        let expectedError = GuardianAPI.Error.unreachable(endPoint.url)
        XCTAssertEqual(errorReceived, expectedError)
    }

    func testReturningUndecodableJSONError() throws {
        let apiProvider = MockAPIProvider()
        apiProvider.resultToReturn = Result.success(apiProvider.sample(file: .wrongFormat))
        let api = GuardianAPI(apiProvider: apiProvider,
                              endpoint: EndPoint.search(filters: []))
        let errorReceived = try waitFailure(for: api.recipes())
        let expectedError = GuardianAPI.Error.wrongJSONStructure
        XCTAssertEqual(errorReceived, expectedError)
    }

    func testAPICallsCorrectURL() throws {
        let apiProvider = MockAPIProvider()
        let api = GuardianAPI(apiProvider: apiProvider,
                              endpoint: EndPoint.search(filters: []))
        let _ = try wait(for:api.recipes())
        XCTAssertCount(apiProvider.urlsInserted, 1)
        let url = try XCTUnwrap(apiProvider.urlsInserted.first)
        XCTAssertContains(url.absoluteString, "https://content.guardianapis.com/search")
    }
}

