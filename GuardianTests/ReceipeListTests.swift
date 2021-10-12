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

//    func testFetchingReceivesError() throws {
//        let vm = RecipeList.ViewModel(apiProvider: MockAPIProvider(returnError: true))
//        let recipesPublisher = vm.$recipes
//            .dropFirst()
//
//        vm.fetch(refresh: false)
//
//        let error = try waitFailure(for: recipesPublisher)
//
//        XCTAssertNotNil(error)
//    }
}
