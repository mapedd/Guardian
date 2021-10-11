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
