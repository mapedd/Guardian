//
//  ReceipeList.swift
//  GuardianUITests
//
//  Created by Tomek on 11/10/2021.
//

import Foundation

class RecipeList : ScreenModel {
    func waitForDataToLoad() -> Self {
        testCase.waitFor(app.tables.cells.firstMatch)
        return self
    }
    func tapItem(at index: Int) -> RecipeDetail {
        app.cells.element(boundBy: index).tap()
        return RecipeDetail(context)
    }
    func scrollDown() -> Self {
        app.tables.firstMatch.swipeUp()
        return self
    }
    func scrollUp() -> Self {
        app.tables.firstMatch.swipeDown()
        return self
    }
}
