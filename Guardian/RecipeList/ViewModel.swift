//
//  ViewModel.swift
//  Guardian
//
//  Created by Tomek on 11/10/2021.
//

import Foundation
import Combine
import SwiftUI
import GuardianBackend

extension RecipeList {
    
    class ViewModel: ObservableObject {
        @Published var recipes = [Item]()
        @Published var error : GuardianAPI.Error? = nil
        @Published var loading : Bool = false
        
        var showError: Binding<Bool> {
            return Binding<Bool>(get: {
                return self.error != nil
            }, set: { newValue in
                guard !newValue else { return }
                self.error = nil
            })
        }

        init(apiProvider: APIProvider) {
            self.api = GuardianAPI(apiProvider: apiProvider)
        }

        let api: GuardianAPI

        var subscriptions = [AnyCancellable]()

        func fetch(refresh: Bool) {
            if refresh {
                loading = true
            }

            api.recipes()
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    self.loading = false
                    if case .failure(let error) = completion {
                        self.error = error
                    }
                }, receiveValue: {
                    self.recipes = $0.asListItems
                })
                .store(in: &subscriptions)
        }
    }
}

extension GuardianResponse {
    var asListItems : [RecipeList.Item] {
        return response.results.map {
            let name = Name(first: $0.authorFirstName, last: $0.authorLastName)
            let author = Author(name: name, pictureURL: $0.authPicURL)
            return RecipeList.Item(topTitle: $0.headline ?? "",
                                   bottomCopy: $0.bodyText ?? "",
                                   imageName: nil,
                                   imageURL: $0.thumbnail,
                                   id: $0.id,
                                   bodyHTML: $0.body ?? "",
                                   author: author)
        }
    }
}
