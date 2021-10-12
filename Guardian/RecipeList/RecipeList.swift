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
                RecipeListElement(item: item)
            }
        }
        .refreshable {
            self.model.fetch(refresh: true)
        }
        .listStyle(PlainListStyle())
        .navigationTitle("Recipes")
        .navigationViewStyle(.stack)
        .alert(isPresented: model.showError) {
            Alert(title: Text("Error loading data"),
                  message: Text("\(model.error?.localizedDescription ?? "")"),
                  dismissButton: nil)
        }
        .loadingIndicator(model.loading)
    }
}

struct RecipeList_Previews: PreviewProvider {
    static func successViewModel () -> RecipeList.ViewModel {
        return RecipeList.ViewModel(apiProvider: MockAPIProvider(returnError: false))
    }
    static func errorViewModel() -> RecipeList.ViewModel {
        return RecipeList.ViewModel(apiProvider: MockAPIProvider(returnError: true))
    }
    static var previews: some View {
        Group {
          // groupings do not seem to work in live mode
//            RecipeList(model: Self.errorViewModel())
//                .previewDisplayName("failure")
//                .previewLayout(.fixed(width: 320, height: 800))

            RecipeList(model: Self.successViewModel())
                .previewDisplayName("success")
                .previewLayout(.fixed(width: 320, height: 800))

        }
    }
}
