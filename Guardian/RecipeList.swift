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
        List {
            ForEach(recipes) { item in
                RecipeCell(item: item)
            }
        }
        .listStyle(PlainListStyle())
        .navigationTitle("Recipes")
    }
}

struct RecipeList_Previews: PreviewProvider {
    static var previews: some View {
        RecipeList(recipes: SampleData().recipeListItems)
    }
}