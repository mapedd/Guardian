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
        VStack {
            Text(item.topTitle)
            Text(item.bottomCopy)
            item.image.resizable()
        }
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
