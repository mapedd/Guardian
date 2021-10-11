//
//  ScreenModel.swift
//  GuardianUITests
//
//  Created by Tomek on 11/10/2021.
//

import Foundation
import XCTest

class ScreenModel {

    var app: XCUIApplication {
        return context.app
    }

    var testCase: UITestCase {
        return context.testCase
    }

    let context: UITestContext

    init(_ context: UITestContext) {
        self.context = context
    }
}

extension ScreenModel {
    func verifyNav(title: String) -> Self{
        testCase.waitFor(app.navigationBars[title].staticTexts[title])
        return self
    }
}
