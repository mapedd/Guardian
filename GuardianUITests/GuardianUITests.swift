//
//  GuardianUITests.swift
//  GuardianUITests
//
//  Created by Tomasz Kuzma on 06/10/2021.
//

import XCTest

class GuardianUITests: UITestCase {

    func testContentNavigationToDetailAndBack() throws {
        let _ = RecipeList(self.context)
            .waitForDataToLoad()
            .verifyNav(title: "Recipes")
            .tapItem(at: 0)
            .verifyAuthor()
            .verifyContent()
            .scrollDown()
            .navigateBack()
        
    }
}

