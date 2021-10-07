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
            Text(item.topTitle)
                .foregroundColor(.gray)
                .font(.caption)
            Text(item.bottomCopy)
                .font(.headline)


            AsyncImage(url: item.imageURL) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                     .frame(maxWidth: 300, maxHeight: 100)
                            case .success(let image):
                                image.resizable()
                                    .cornerRadius(10)
                                    .aspectRatio(3.0/2.0, contentMode: .fit)
                            case .failure:
                                Image("placeholder")
                            @unknown default:
                                // Since the AsyncImagePhase enum isn't frozen,
                                // we need to add this currently unused fallback
                                // to handle any new cases that might be added
                                // in the future:
                                EmptyView()
                            }
                        }

        }
    }
}

struct RecipeCell_Previews: PreviewProvider {

    static var previews: some View {
        let items = SampleData().recipeListItems
        Group {
            RecipeCell(item: items[0])
            RecipeCell(item: items[1])
        }
        .previewLayout(.sizeThatFits)
    }
}
