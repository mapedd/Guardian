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


public class GuardianAPI {

    public enum Error: LocalizedError {
        case unreachable(URL)
        case invalidResponse
        case wrongJSONStructure

        public var errorDescription: String? {
            switch self {
            case .invalidResponse: return "Cannot decode data."
            case .unreachable(let url): return "\(url.absoluteString) is unreachable."
            case .wrongJSONStructure: return "adjust your Decodable structure of the response"
            }
        }
    }

    public enum EndPoint {
        static let baseURL = URL(string: "https://content.guardianapis.com/search?tag=tone%2Frecipes&from-date=2010-01-01&show-tags=contributor&show-fields=all&api-key=b3437fe8-33dd-4b67-a90b-e2bdb634fcb3")!

        case recipes

        var url: URL {
            switch self {
            case .recipes:
                return EndPoint.baseURL
            }
        }
    }

    private let apiQueue = DispatchQueue(label: "API.guardian",
                                         qos: .default,
                                         attributes: .concurrent)

    private let decoder = JSONDecoder()

    private let apiProvider: APIProvider

    public init(apiProvider: APIProvider) {
        self.apiProvider = apiProvider
    }


    public func recipes() -> AnyPublisher<GuardianResponse, Error> {
        apiProvider
            .apiResponse(for: Self.EndPoint.recipes.url)
            .receive(on: apiQueue)
            .map(\.data)
            .decode(type: GuardianResponse.self, decoder: decoder)
            .mapError { error in
                switch error {
                case is URLError:
                    return Error.unreachable(EndPoint.recipes.url)
                case is DecodingError:
                    return Error.wrongJSONStructure
                default: return Error.invalidResponse
                }
            }
            .eraseToAnyPublisher()
    }

}
