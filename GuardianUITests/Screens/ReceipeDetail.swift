//
//  File.swift
//  GuardianUITests
//
//  Created by Tomek on 11/10/2021.
//

import Foundation

class RecipeDetail : ScreenModel {
    func verifyAuthor() -> Self {
        return self
    }
    func verifyContent() -> Self {
        return self
    }
    func scrollDown() -> Self {
        let scrollViewsQuery = app.scrollViews
        scrollViewsQuery.firstMatch.swipeDown()
        return self
    }
    func scrollUp() -> Self {
        let scrollViewsQuery = app.scrollViews
        scrollViewsQuery.firstMatch.swipeDown()
        return self
    }
    func navigateBack() -> RecipeList {
        app.navigationBars.firstMatch.buttons["Recipes"].tap()
        return RecipeList(context)
    }
}
