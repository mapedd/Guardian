//
//  Item.swift
//  Guardian
//
//  Created by Tomek on 11/10/2021.
//

import Foundation
import SwiftUI

extension RecipeList {
    struct Item: Hashable, Identifiable {
        let topTitle: String
        let bottomCopy: String
        let imageName: String?
        let imageURL: URL?
        let id: String
        let bodyHTML: String

        var image: Image? {
            if let imageName = imageName {
                return Image(imageName)
            } else {
                return nil
            }
        }

        var asDetailItem: RecipeDetail.Item {
            RecipeDetail.Item(author: Name(first: "Thomas", last: "Kuzma"),
                              title: topTitle,
                              body: bodyHTML,
                              image: nil,
                              imageURL: imageURL)
        }
    }
}
