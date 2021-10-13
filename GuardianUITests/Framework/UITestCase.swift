//
//  UITestCase.swift
//  GuardianUITests
//
//  Created by Tomasz Kuzma on 06/10/2021.
//


import XCTest


typealias UITestContext = (app: XCUIApplication, testCase: UITestCase)


class UITestCase: XCTestCase {
    private(set) var app: XCUIApplication!

    var context: UITestContext {
        return (app: app, testCase: self)
    }

    override func setUpWithError() throws {
        try super.setUpWithError()
        launchApp()
    }

    var additionalEnvVars = [String:String]()

    private func launchApp() {
        app = XCUIApplication()

        let env = ["mockNetwork": "true"].merging(additionalEnvVars) { (_, new) -> String in new}

        app.launchEnvironment = env
        app.launch()
    }

    func waitFor(_ element: XCUIElement,
                 waitSeconds: TimeInterval = 15,
                 filePath: String = #file,
                 lineNumber: UInt = #line) {

        let existsPredicate = NSPredicate(format: "exists == true")

        expectation(for: existsPredicate, evaluatedWith: element, handler: nil)

        waitForExpectations(timeout: waitSeconds) { (error) -> Void in

            if (error != nil) {
                let location = XCTSourceCodeLocation(filePath: filePath, lineNumber: Int(lineNumber))
                let message = "Failed to find \(element) after waiting \(waitSeconds) seconds."
                let issue = XCTIssue(type: .assertionFailure,
                                     compactDescription: "waiting for element failed",
                                     detailedDescription: message,
                                     sourceCodeContext: XCTSourceCodeContext(location: location),
                                     associatedError: nil,
                                     attachments: [])
                self.record(issue)
            }
        }
    }
}

