//
//  RecipeListConversionTests.swift
//  GuardianTests
//
//  Created by Tomasz Kuzma on 12/10/2021.
//

import XCTest
@testable import Guardian

class RecipeListConversionTests: XCTestCase {

    func testMappingFromRecipeItemToDetail() {
        let author = Author(name: Name(first: "first", last: "last"),
                            pictureURL: URL(string: "http://picture.url")!)
        let recipeListItem = RecipeList.Item(topTitle: "topTitle",
                                             bottomCopy: "bottomCopy",
                                             imageName: "",
                                             imageURL: URL(string: "http://delli.market")!,
                                             id: "id",
                                             bodyHTML: "body HTML",
                                             author: author)

        let detail = recipeListItem.asDetailItem

        XCTAssertEqual(detail.body, "body HTML")
        XCTAssertEqual(detail.author, author)
        XCTAssertEqual(detail.title, "topTitle")
        XCTAssertEqual(detail.imageURL, URL(string: "http://delli.market")!)
    }
}
