//
//  RecipeListElement.swift
//  Guardian
//
//  Created by Tomasz Kuzma on 12/10/2021.
//

import SwiftUI

struct RecipeListElement : View{

    let item: RecipeList.Item

    var body: some View {
        ZStack { // wrapping in ZStack to hide chevron
            RecipeCell(item: item)
            if let detail = item.asDetailItem {
                NavigationLink(destination: {
                    RecipeDetail(item: detail)
                }, label: {
                }).opacity(0)
            }

        }
    }
}
