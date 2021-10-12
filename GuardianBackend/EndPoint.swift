//
//  EndPoint.swift
//  GuardianBackend
//
//  Created by Tomasz Kuzma on 12/10/2021.
//

import Foundation


public typealias APIKey = String

public enum Filter {
    case apiKey(key: APIKey)
    case showFields(fields : [AdditionalInfoField])
    case tagsToShow(tags: [TagToShow])
    case tagsToFilterBy(tags: [TagToFilter])


    var queryItem: URLQueryItem {
        switch self {
        case .apiKey(key:let key):
            return URLQueryItem(name: "api-key", value: key)
        case .showFields(fields: let fields):
            return URLQueryItem(name: "show-fields", value: fields.map { $0.rawValue}.joined(separator: ","))
        case .tagsToShow(tags: let tags):
            return URLQueryItem(name: "show-tags", value: tags.map { $0.rawValue}.joined(separator: ","))
        case .tagsToFilterBy(tags: let tags):
            return URLQueryItem(name: "tag", value: tags.map { $0.rawValue}.joined(separator: ","))
        }
    }
}

public enum AdditionalInfoField: String {
    case thumbnail
    case headline
    case body
    case byline
    case all
}

public enum TagToFilter: String {
    case toneRecipes = "tone/recipes"
}

public enum TagToShow : String {
    case series
    case contributor
}



public enum EndPoint {

    static let baseSearchURL = URL(string: "https://content.guardianapis.com/search")!

    case search(filters: [Filter])

    public var url: URL {
        switch self {
        case .search(let filters):
            return Self.baseSearchURL.appending(filters)
        }
    }
}

let apiKey = "b3437fe8-33dd-4b67-a90b-e2bdb634fcb3"

public func search_delli() -> EndPoint { // used in the task description
    let filters: [Filter] = [
        .tagsToFilterBy(tags: [.toneRecipes]),
        .tagsToShow(tags: [.series]),
        .showFields(fields: [.thumbnail, .headline]),
        .apiKey(key: apiKey),
    ]
    return EndPoint.search(filters: filters)
}

public func search_tomek() ->  EndPoint { // get author data and body content. can be used to show details screen
    let filters: [Filter] = [
        .apiKey(key: apiKey),
        .showFields(fields: [.all]),
        .tagsToShow(tags: [.contributor]),
        .tagsToFilterBy(tags: [.toneRecipes])
    ]
    return EndPoint.search(filters: filters)
}
