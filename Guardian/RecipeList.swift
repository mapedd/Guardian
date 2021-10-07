//
//  RecipeList.swift
//  Guardian
//
//  Created by Tomasz Kuzma on 06/10/2021.
//

import SwiftUI
import Combine

struct RecipeList: View {

    class ViewModel: ObservableObject {
        @Published var recipes = [Item]()

        let api = GuardianAPI()
        var subscriptions = [AnyCancellable]()

        func fetch() {
            api.recipes()
                .sink(receiveCompletion: { print($0) },
                      receiveValue: { print($0) })
                .store(in: &subscriptions)
        }
    }

    struct Item: Hashable, Identifiable {
        let topTitle: String
        let bottomCopy: String
        let imageName: String
        let id: String

        var image: Image {
            Image(imageName)
        }
    }

    @ObservedObject var model: ViewModel

    init(model: ViewModel) {
        self.model = model
    }

    var body: some View {
        List {
            ForEach(self.model.recipes) { item in
                RecipeCell(item: item)
            }
        }
        .listStyle(PlainListStyle())
        .navigationTitle("Recipes")
        .onAppear{
            self.model.fetch()
        }
    }
}

//struct RecipeList_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeList(recipes: SampleData().recipeListItems)
//    }
//}
