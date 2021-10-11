//
//  RecipeList.swift
//  Guardian
//
//  Created by Tomasz Kuzma on 06/10/2021.
//

import SwiftUI
import Combine
import GuardianBackend

struct RecipeList: View {
    @ObservedObject var model: ViewModel

    init(model: ViewModel) {
        self.model = model
    }

    var body: some View {
        List {
            ForEach(self.model.recipes) { item in


                ZStack { // wrapping in ZStack to hide chevron
                    RecipeCell(item: item)
                    NavigationLink(destination: {
                        RecipeDetail(item: item.asDetailItem)
                    }, label: {

                    }).opacity(0)
                }
                
            }
        }
        .refreshable {
            self.model.fetch()
        }
        .listStyle(PlainListStyle())
        .navigationTitle("Recipes")
        .navigationViewStyle(.stack)
        .onAppear{
            self.model.fetch()
        }
    }
}

struct RecipeList_Previews: PreviewProvider {
    static var previews: some View {
        let apiProvider = MockAPIProvider()
        let viewModel = RecipeList.ViewModel(apiProvider: apiProvider)
        RecipeList(model: viewModel)
    }
}
