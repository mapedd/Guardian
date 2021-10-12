//
//  EndPointTests.swift
//  GuardianBackendTests
//
//  Created by Tomasz Kuzma on 12/10/2021.
//

import XCTest
import GuardianBackend

class EndPointTests: XCTestCase {
    func testURLConstruction_APIKEY() {
        let endPoint = EndPoint.search(filters: [.apiKey(key: "apiKey")])
        XCTAssertEqual(endPoint.url.absoluteString, "https://content.guardianapis.com/search?api-key=apiKey")
    }
    func testURLConstruction_ShowFields() {
        let fields = [AdditionalInfoField.thumbnail, AdditionalInfoField.headline]
        let filters = [Filter.showFields(fields: fields)]
        let endPoint = EndPoint
            .search(filters: filters)
        XCTAssertEqual(endPoint.url.absoluteString, "https://content.guardianapis.com/search?show-fields=thumbnail,headline")
    }
    func testURLConstruction_ShowTags() {
        let tags = [TagToShow.contributor, TagToShow.series]
        let filters = [Filter.tagsToShow(tags: tags)]
        let endPoint = EndPoint.search(filters: filters)
        XCTAssertEqual(endPoint.url.absoluteString, "https://content.guardianapis.com/search?show-tags=contributor,series")
    }
    func testURLConstruction_Tag() {
        let tags = [TagToFilter.toneRecipes]
        let filters = [Filter.tagsToFilterBy(tags: tags)]
        let endPoint = EndPoint
            .search(filters: filters)
        XCTAssertEqual(endPoint.url.absoluteString, "https://content.guardianapis.com/search?tag=tone/recipes")
    }
    func testURLConstruction_delli() {
        let endPoint = search_delli()
        XCTAssertEqual(endPoint.url.absoluteString, "https://content.guardianapis.com/search?tag=tone/recipes&show-tags=series&show-fields=thumbnail,headline&api-key=b3437fe8-33dd-4b67-a90b-e2bdb634fcb3")
    }
    func testURLConstruction_tomek() {
        let endPoint = search_tomek()
        XCTAssertEqual(endPoint.url.absoluteString, "https://content.guardianapis.com/search?api-key=b3437fe8-33dd-4b67-a90b-e2bdb634fcb3&show-fields=all&show-tags=contributor&tag=tone/recipes")
    }
}
