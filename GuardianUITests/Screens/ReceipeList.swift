//
//  ReceipeList.swift
//  GuardianUITests
//
//  Created by Tomek on 11/10/2021.
//

import Foundation

class RecipeList : ScreenModel {
    func waitForDataToLoad() -> Self {
        return self
    }
    func tapItem(at index: Int) -> RecipeDetail {
        return RecipeDetail(context)
    }
}
