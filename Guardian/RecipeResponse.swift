//
//  RecipeResponse.swift
//  Guardian
//
//  Created by Tomasz Kuzma on 07/10/2021.
//

import Foundation

struct GuardianResponse: Codable, Hashable  {
    var response: RecipeResponse
}

struct RecipeResponse: Codable, Hashable {
    struct Recipe: Codable, Hashable {
        let id: String

        let fields: [String: String]

        var headline: String? {
            return fields["headline"]
        }

        var bodyText: String? {
            return fields["bodyText"]
        }

        var thumbnail: URL? {
            guard let thumbnailString = fields["thumbnail"],
                  let thumbnailURL = URL(string: thumbnailString) else {
                      return nil
                  }

            return thumbnailURL
        }


    }

    let results: [Recipe]
}
