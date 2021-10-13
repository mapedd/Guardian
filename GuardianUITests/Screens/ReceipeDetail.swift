//
//  File.swift
//  GuardianUITests
//
//  Created by Tomek on 11/10/2021.
//

import Foundation

class RecipeDetail : ScreenModel {

    func verifyContent() -> Self {
        app.scrollViews.otherElements.staticTexts["item.title-Thomasina Miers’ recipe for roast chicken legs with sticky figs, red onions and oloroso vinegar"].tap()
        return self
    }
    
    func navigateBack() -> RecipeList {
        app.navigationBars.firstMatch.buttons["Recipes"].tap()
        return RecipeList(context)
    }
    func scrollDown() -> Self {
        let scrollViewsQuery = app.scrollViews
        scrollViewsQuery.firstMatch.swipeUp()
        return self
    }
    func scrollUp() -> Self {
        let scrollViewsQuery = app.scrollViews
        scrollViewsQuery.firstMatch.swipeDown()
        return self
    }
}
