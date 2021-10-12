//
//  RecipeResponseTests.swift
//  GuardianBackendTests
//
//  Created by Tomasz Kuzma on 12/10/2021.
//

import XCTest
import GuardianBackend

class RecipeResponseTests: XCTestCase {
    func testReadingOptionalFieldsAndTagsYieldsNil() throws {
        let results = RecipeResponse.Recipe(id: "id",
                                            fields: [:],
                                            tags: [])
        let mainResponse = GuardianResponse(response: RecipeResponse(results: [results]))
        let firstRecipe = try XCTUnwrap(mainResponse.firstRecipe)

        XCTAssertNil(firstRecipe.authorLastName)
        XCTAssertNil(firstRecipe.authorFirstName)
        XCTAssertNil(firstRecipe.authPicURL)
        XCTAssertNil(firstRecipe.body)
        XCTAssertNil(firstRecipe.bodyText)
        XCTAssertNil(firstRecipe.headline)
        XCTAssertNil(firstRecipe.thumbnail)
    }

    func testReadingOptionalFieldsAndTagsYieldsExpectedValues() throws {
        let fields = [RecipeResponse.Recipe.FieldKey.headline.rawValue: "headline",
                      RecipeResponse.Recipe.FieldKey.body.rawValue: "body",
                      RecipeResponse.Recipe.FieldKey.bodyText.rawValue: "bodyText",
                      RecipeResponse.Recipe.FieldKey.thumbnail.rawValue: "http://www.thumbnail.com"]

        let tags =   [RecipeResponse.Recipe.TagKey.bylineImageUrl.rawValue: RecipeResponse.Recipe.TagValue.string("http://www.bylineImageUrl.com"),
                      RecipeResponse.Recipe.TagKey.firstName.rawValue: RecipeResponse.Recipe.TagValue.string("firstName"),
                      RecipeResponse.Recipe.TagKey.lastName.rawValue: RecipeResponse.Recipe.TagValue.string("lastName")]

        let results = RecipeResponse.Recipe(id: "id",
                                            fields: fields,
                                            tags: [tags])

        let mainResponse = GuardianResponse(response: RecipeResponse(results: [results]))
        let firstRecipe = try XCTUnwrap(mainResponse.firstRecipe)

        XCTAssertEqual(firstRecipe.authorLastName, "lastName")
        XCTAssertEqual(firstRecipe.authorFirstName, "firstName")
        XCTAssertEqual(firstRecipe.authPicURL, URL(string: "http://www.bylineImageUrl.com"))
        XCTAssertEqual(firstRecipe.thumbnail, URL(string: "http://www.thumbnail.com"))
        XCTAssertEqual(firstRecipe.body, "body")
        XCTAssertEqual(firstRecipe.bodyText, "bodyText")
        XCTAssertEqual(firstRecipe.headline, "headline")
    }

}

extension GuardianResponse {
    var firstRecipe: RecipeResponse.Recipe? {
        return response.results.first
    }
}
