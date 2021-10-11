//
//  RecipeResponse.swift
//  Guardian
//
//  Created by Tomasz Kuzma on 07/10/2021.
//

import Foundation

public struct GuardianResponse: Decodable, Hashable  {
    public var response: RecipeResponse
    public init(response: RecipeResponse) {
        self.response = response
    }
}

public struct RecipeResponse: Decodable, Hashable {
    public struct Recipe: Decodable, Hashable {
        public let id: String

        public let fields: [String: String]

        public var headline: String? {
            return fields["headline"]
        }

        public var bodyText: String? {
            return fields["bodyText"]
        }
        public var body: String? {
            return fields["body"]
        }

        public var tags: [[String: TagValue]]

        public enum TagValue: Decodable, Hashable {
            
            case string(String)
            case unknown

            public init(from decoder: Decoder) throws {
                // we accept only strings as tag values here, this can return other types so safegaurding
                let container = try decoder.singleValueContainer()
                if let stringValue = try? container.decode(String.self) {
                    self = .string(stringValue)
                } else {
                    self = .unknown
                }
            }
        }

        private var firstTags: [String:TagValue] {
            return tags.first ?? [:]
        }

        public var authPicURL: URL? {
            guard case let .string(bylineURL) = firstTags["bylineImageUrl"],
                    let url = URL(string: bylineURL)
            else {
                return nil
            }

            return url
        }

        public var authorFirstName: String? {
            guard case let .string(value) = firstTags["firstName"] else {
                return nil
            }
            return value
        }

        public var authorLastName: String? {
            guard case let .string(value) = firstTags["lastName"] else {
                return nil
            }
            return value
        }

        public var thumbnail: URL? {
            guard let thumbnailString = fields["thumbnail"],
                  let thumbnailURL = URL(string: thumbnailString) else {
                      return nil
                  }

            return thumbnailURL
        }


    }

    public let results: [Recipe]
    
    public init(results: [Recipe]) {
        self.results = results
    }
}
