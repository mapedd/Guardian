//
//  ContentView.swift
//  Guardian
//
//  Created by Tomasz Kuzma on 06/10/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            RecipeList(recipes: SampleData().recipeListItems)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }


    func fetch() {
        let url = URL(string: "https://content.guardianapis.com/search")!
        URLSession.shared.dataTaskPublisher(for: url)
    }
}
