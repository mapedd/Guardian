//
//  RecipeList.swift
//  Guardian
//
//  Created by Tomasz Kuzma on 06/10/2021.
//

import SwiftUI

struct RecipeList: View {
    struct Item: Hashable, Identifiable {
        let topTitle: String
        let bottomCopy: String
        let imageName: String
        let id: String

        var image: Image {
            Image(imageName)
        }
    }
    var recipes: [Item]
    var body: some View {
        NavigationView {
            List {
                ForEach(recipes) { item in
                    RecipeCell(item: item)
                }
            }
        }
        .navigationTitle("Recipes")
    }
}

struct RecipeList_Previews: PreviewProvider {
    static var previews: some View {
        let item = RecipeList.Item(topTitle: "KITCHEN AIDE",
                                   bottomCopy: "Is it OK to buy readymade pastry, or should I make it myself?",
                                   imageName: "test0",
                                   id: "0")
        RecipeList(recipes: [item])
    }
}
