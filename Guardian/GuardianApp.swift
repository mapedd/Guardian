//
//  GuardianApp.swift
//  Guardian
//
//  Created by Tomasz Kuzma on 06/10/2021.
//

import SwiftUI
import GuardianBackend

@main
struct GuardianApp: App {

    var body: some Scene {
        WindowGroup {
            if isTesting { // do not load anything in the unit tests
                EmptyView()
            } else {
                ContentView(apiProvider: self.provider)
            }
        }
    }
}
