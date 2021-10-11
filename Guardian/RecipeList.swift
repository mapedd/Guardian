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

        init(apiProvider: APIProvider) {
            self.api = GuardianAPI(apiProvider: apiProvider)
        }

        let api: GuardianAPI
        var error : GuardianAPI.Error? = nil
        var subscriptions = [AnyCancellable]()

        func fetch() {
            api.recipes()
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        self.error = error
                    }
                }, receiveValue: {
                    /*
                     Publishing changes from background threads is not allowed; make sure to publish values from the main thread (via operators like receive(on:)) on model updates.
                     */
                    self.recipes = $0.response.results.map {
                        Item(topTitle: $0.headline ?? "",
                             bottomCopy: $0.bodyText ?? "",
                             imageName: nil,
                             imageURL: $0.thumbnail,
                             id: $0.id,
                             bodyHTML: $0.body ?? "")
                    }
                })
                .store(in: &subscriptions)
        }
    }

    struct Item: Hashable, Identifiable {
        let topTitle: String
        let bottomCopy: String
        let imageName: String?
        let imageURL: URL?
        let id: String
        let bodyHTML: String

        var image: Image? {
            if let imageName = imageName {
                return Image(imageName)
            } else {
                return nil
            }
        }

        var asDetailItem: RecipeDetail.Item {
            RecipeDetail.Item(author: Name(first: "Thomas", last: "Kuzma"),
                                               title: topTitle,
                                               body: bodyHTML,
                                               image: nil,
                                               imageURL: imageURL)
        }
    }

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

//struct RecipeList_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeList(recipes: SampleData().recipeListItems)
//    }
//}
