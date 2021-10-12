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

    public let results: [Recipe]

    public init(results: [Recipe]) {
        self.results = results
    }

    public struct Recipe: Decodable, Hashable {

        public enum FieldKey : String {
            case headline
            case bodyText
            case body
            case thumbnail
        }

        public enum TagKey: String {
            case bylineImageUrl
            case firstName
            case lastName
        }

        public init(id: String,
                    fields: [String: String],
                    tags: [[String: TagValue]]) {
            self.id = id
            self.fields = fields
            self.tags = tags
        }

        

        public let id: String
        public let fields: [String: String]
        public var tags: [[String: TagValue]]
        public var webTitle: String?

        public var headline: String? {
            return fields[FieldKey.headline.rawValue]
        }

        public var bodyText: String? {
            return fields[FieldKey.bodyText.rawValue]
        }
        public var body: String? {
            return fields[FieldKey.body.rawValue]
        }

        public var thumbnail: URL? {
            guard let thumbnailString = fields[FieldKey.thumbnail.rawValue],
                  let thumbnailURL = URL(string: thumbnailString) else {
                      return nil
                  }

            return thumbnailURL
        }

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
            guard case let .string(bylineURL) = firstTags[TagKey.bylineImageUrl.rawValue],
                  let url = URL(string: bylineURL)
            else {
                return nil
            }

            return url
        }

        public var authorFirstName: String? {
            guard case let .string(value) = firstTags[TagKey.firstName.rawValue] else {
                return nil
            }
            return value
        }

        public var authorLastName: String? {
            guard case let .string(value) = firstTags[TagKey.lastName.rawValue] else {
                return nil
            }
            return value
        }
    }
}
