//
//  RecipeResponse.swift
//  Guardian
//
//  Created by Tomasz Kuzma on 07/10/2021.
//

import Foundation

struct RecipeResponse: Decodable, Hashable {
    struct Recipe: Decodable, Hashable {
        let id: String
        let sectionName: String
        let fields: [String: String]

        var headline: String? {
            return fields["headline"]
        }

        var shortURL: String? {
            return fields["shortUrl"]
        }
    }

    let results: [Recipe]
}
