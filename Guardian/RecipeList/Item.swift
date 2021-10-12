//
//  Item.swift
//  Guardian
//
//  Created by Tomek on 11/10/2021.
//

import Foundation
import SwiftUI

struct Author: Hashable {
    var name: Name
    var pictureURL: URL?
}


struct Name: Hashable {
    let first: String?
    let last: String?
}


extension RecipeList {
    struct Item: Hashable, Identifiable {
        let topTitle: String
        let bottomCopy: String
        let imageName: String?
        let imageURL: URL?
        let id: String
        let bodyHTML: String
        let author: Author?

        var image: Image? {
            if let imageName = imageName {
                return Image(imageName)
            } else {
                return nil
            }
        }

        var asDetailItem: RecipeDetail.Item? {
            // if no author data we do not show details screen
            guard let author = author else {
                return nil
            }
            return RecipeDetail.Item(author: author,
                                     title: topTitle,
                                     body: bodyHTML,
                                     image: nil,
                                     imageURL: imageURL)
        }
    }
}
