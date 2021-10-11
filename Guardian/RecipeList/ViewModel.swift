//
//  ViewModel.swift
//  Guardian
//
//  Created by Tomek on 11/10/2021.
//

import Foundation
import Combine
import SwiftUI

extension RecipeList {
    
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
}
