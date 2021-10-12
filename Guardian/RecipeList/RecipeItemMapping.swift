//
//  RecipeItemMapping.swift
//  Guardian
//
//  Created by Tomasz Kuzma on 12/10/2021.
//

import Foundation
import GuardianBackend

extension GuardianResponse {
    func author(from recipe: RecipeResponse.Recipe) -> Author? {
        guard let first = recipe.authorFirstName, let last = recipe.authorLastName else {
            return nil
        }

        let name = Name(first: first, last: last)
        let author = Author(name: name,
                            pictureURL: recipe.authPicURL)
        return author
    }

    var asListItems : [RecipeList.Item] {
        return response.results.map {

            return RecipeList.Item(topTitle: $0.headline ?? "",
                                   bottomCopy: $0.bodyText ?? $0.webTitle ?? "",
                                   imageName: nil,
                                   imageURL: $0.thumbnail,
                                   id: $0.id,
                                   bodyHTML: $0.body ?? "",
                                   author: author(from: $0))
        }
    }
}
