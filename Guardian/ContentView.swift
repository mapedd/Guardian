//
//  ContentView.swift
//  Guardian
//
//  Created by Tomasz Kuzma on 06/10/2021.
//

import SwiftUI
import Combine
import GuardianBackend

struct ContentView: View {
    
    let viewModel: RecipeList.ViewModel
    
    init(apiProvider: APIProvider,
         showingDetailsScreen: Bool = false) {
        viewModel = RecipeList.ViewModel(apiProvider: apiProvider,
                                         showDetailsScreen: showingDetailsScreen)
        viewModel.fetch(refresh: false)
    }
    
    var body: some View {
        NavigationView {
            RecipeList(model: viewModel)
        }
        .accentColor( .white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(apiProvider: MockAPIProvider())
    }

}
