//
//  GuardianUITests.swift
//  GuardianUITests
//
//  Created by Tomasz Kuzma on 06/10/2021.
//

import XCTest

class GuardianUITests: UITestCase {

    override func setUpWithError() throws {
        self.additionalEnvVars = ["showDetailScreen" : "true"]
        try super.setUpWithError()
    }

    func testContentNavigationToDetailAndBack() throws {
        let _ = RecipeList(self.context)
            .waitForDataToLoad()
            .verifyNav(title: "Recipes")
            .scrollDown()
            .scrollUp()
            .tapItem(at: 0)
            .verifyContent()
            .scrollDown()
            .scrollUp()
            .navigateBack()
    }
}

