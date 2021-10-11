//
//  RecipeListViewModelTests.swift
//  GuardianTests
//
//  Created by Tomek on 11/10/2021.
//

import XCTest
@testable import Guardian
import GuardianBackend

class RecipeListViewModelTests: XCTestCase {
    func testFetchingNoRefresh() {
        let vm = RecipeList.ViewModel(apiProvider: MockAPIProvider())
        vm.fetch(refresh: false)
    }
}
