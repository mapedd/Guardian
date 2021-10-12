//
//  ReceipeListTests.swift
//  GuardianTests
//
//  Created by Tomasz Kuzma on 12/10/2021.
//

import XCTest
@testable import Guardian
import GuardianBackend
import TestingExtensions

class RecipeListViewModelTests: XCTestCase {
    func testFetchingNoRefresh() throws {
        let vm = RecipeList.ViewModel(apiProvider: MockAPIProvider())
        let recipesPublisher = vm.$recipes
            .dropFirst() // first one is default value
            .collect(1)
            .first()

        vm.fetch(refresh: false)
        let recipes: [[RecipeList.Item]] = try wait(for: recipesPublisher)
        let inner = try XCTUnwrap(recipes.first)
        XCTAssertCount(inner, 2)
    }

    func testFetchingReceivesError() throws {
        let vm = RecipeList.ViewModel(apiProvider: MockAPIProvider(returnError: true))
        let errorPublisher = vm.$error
            .dropFirst()
            .collect(1)
            .first()

        vm.fetch(refresh: false)

        let error: [GuardianAPI.Error?] = try waitFor(firstOutput: errorPublisher)
        let expectedErrors = [GuardianAPI.Error.unreachable(GuardianAPI.EndPoint.recipes.url)]
        XCTAssertEqual(error, expectedErrors)
    }
}
