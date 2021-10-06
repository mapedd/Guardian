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
            item.image
                .resizable()
                .cornerRadius(10)
                .aspectRatio(3.0/2.0, contentMode: .fit)
        }
        .padding()
    }
}

struct RecipeCell_Previews: PreviewProvider {
    static var previews: some View {
        let item = RecipeList.Item(topTitle: "KITCHEN AIDE",
                                   bottomCopy: "Is it OK to buy readymade pastry, or should I make it myself?",
                                   imageName: "test0",
                                   id: "0")
        RecipeCell(item: item)
    }
}
