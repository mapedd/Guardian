//
//  RecipeList.swift
//  Guardian
//
//  Created by Tomasz Kuzma on 06/10/2021.
//

import SwiftUI
import Combine
import GuardianTests

struct RecipeList: View {
    @ObservedObject var model: ViewModel

    init(model: ViewModel) {
        self.model = model
    }

    var body: some View {
        List {
            ForEach(self.model.recipes) { item in
                NavigationLink(destination: RecipeDetail(item: item.asDetailItem)) {
                    RecipeCell(item: item)
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
        let viewModel = RecipeList.ViewModel(apiProvider: MockAPIProvider())
        RecipeList(model: viewModel)
    }
}
