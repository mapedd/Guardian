//
//  ContentView.swift
//  Guardian
//
//  Created by Tomasz Kuzma on 06/10/2021.
//

import SwiftUI
import Combine

struct ContentView: View {
    let viewModel = RecipeList.ViewModel(publisher: URLSession.shared)
    var body: some View {
        NavigationView {
            RecipeList(model: viewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }

}
