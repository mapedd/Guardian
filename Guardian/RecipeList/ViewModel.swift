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

        static func endPoint(_ showDetails: Bool) -> EndPoint {
            if showDetails {
                return search_tomek()
            } else {
                return search_delli()
            }
        }

        public init(apiProvider: APIProvider, showDetailsScreen: Bool = false) {
            self.api = GuardianAPI(apiProvider: apiProvider,
                                   endpoint: Self.endPoint(showDetailsScreen))
        }

        let api: GuardianAPI

        var subscriptions = [AnyCancellable]()

        public func fetch(refresh: Bool) {
            if !refresh {
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
