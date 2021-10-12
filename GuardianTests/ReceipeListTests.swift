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
        let recipesPublisher = vm.$recipes.collectNext(1)
        vm.fetch(refresh: false)
        let recipes: [[RecipeList.Item]] = try wait(for: recipesPublisher)
        let inner = try XCTUnwrap(recipes.first)
        XCTAssertCount(inner, 2)
    }

    func testFetchingReceivesError() throws {
        let vm = RecipeList.ViewModel(apiProvider: MockAPIProvider(returnError: true))
        let errorPublisher = vm.$error.collectNext(1)

        vm.fetch(refresh: false)

        let error: [GuardianAPI.Error?] = try waitFor(firstOutput: errorPublisher)
        let expectedErrors = [GuardianAPI.Error.unreachable(search_delli().url)]
        XCTAssertEqual(error, expectedErrors)
    }

    func testFetchingTogglesLoading() throws {
        let vm = RecipeList.ViewModel(apiProvider: MockAPIProvider())
        let loadingPublisher = vm.$loading.collect(2)

        vm.fetch(refresh: false)

        let output = try waitFor(firstOutput: loadingPublisher)

        XCTAssertEqual(output, [true, false])
    }

    func testFetchingNotTogglesLoading() throws {
        let vm = RecipeList.ViewModel(apiProvider: MockAPIProvider())
        let loadingPublisher = vm.$loading.collect(1)

        vm.fetch(refresh: true)

        let output = try waitFor(firstOutput: loadingPublisher)

        XCTAssertEqual(output, [false])
    }
}
