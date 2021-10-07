//
//  Network.swift
//  Guardian
//
//  Created by Tomasz Kuzma on 06/10/2021.
//

import Foundation

import Combine

//- tag - tone/recipes
//- show-tags - series
//- show-fields - thumbnail, headline

enum Filters {
    case showFields(fields : [AdditionalInfoField])
    case tagsToShow(tags: [TagToShow])
    case tagsToFilterBy(tags: [TagToFilter])
}

enum AdditionalInfoField: String {
    case thumbnail
    case headline
}

enum TagToFilter {
    case tone
    case recipes
}

enum TagToShow : String {
    case series
}

struct GuardianAPI {

    enum Error: LocalizedError {
        case unreachable(URL)
        case invalidResponse

        var errorDescription: String? {
            switch self {
            case .invalidResponse: return "Cannot docode data."
            case .unreachable(let url): return "\(url.absoluteString) is unreachable."
            }
        }
    }

    enum EndPoint {
        static let baseURL = URL(string: "https://content.guardianapis.com/search")!

        case recipes

        var url: URL {
            switch self {
            case .recipes:
                return EndPoint.baseURL.appendingPathComponent("newstories.json")
            }
        }
    }

    private let apiQueue = DispatchQueue(label: "API.guardian",
                                         qos: .default,
                                         attributes: .concurrent)

    private let decoder = JSONDecoder()


    func recipes() -> AnyPublisher<RecipeResponse, Error> {
        URLSession.shared
            .dataTaskPublisher(for: Self.EndPoint.recipes.url)
            .receive(on: apiQueue)
            .map(\.data)
            .decode(type: RecipeResponse.self, decoder: decoder)
            .catch { _ in Empty<RecipeResponse, Error>() }
            .eraseToAnyPublisher()
    }

}
