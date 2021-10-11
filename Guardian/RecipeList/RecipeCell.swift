//
//  RecipeCell.swift
//  Guardian
//
//  Created by Tomasz Kuzma on 06/10/2021.
//

import SwiftUI

struct RecipeCell: View {
    var item: RecipeList.Item
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
                .frame(height: 8)
            
            Text(item.topTitle)
                .foregroundColor(.gray)
                .font(.caption)
                .accessibility(label: Text("title \(item.topTitle)"))

            Spacer()
                .frame(height: 8)

            Text(item.bottomCopy)
                .font(.headline)
                .lineLimit(2)
                .accessibility(label: Text("subtitle \(item.bottomCopy)"))


            AsyncImageWithPlaceholder(placeholderImageName: "placeholder",
                                      imageURL: item.imageURL,
                                      staticImage: item.image)
            Spacer()
                .frame(height: 8)


        }
        .accessibility(label: Text(item.bottomCopy))
    }
}

struct RecipeCell_Previews: PreviewProvider {

    static var previews: some View {
        let items = SampleRecipeList().recipeListItems
        Group {
            RecipeCell(item: items[0])
            RecipeCell(item: items[1])
        }
        .previewLayout(.sizeThatFits)
    }
}
