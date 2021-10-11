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
    var testing: Bool {
        return ProcessInfo.processInfo.environment["mockNetwork"] != nil
    }
    
    var provider : APIProvider {
        if testing {
            return MockAPIProvider()
        } else {
            return URLSession.shared
        }
    }
    var body: some Scene {
        WindowGroup {
            ContentView(apiProvider: provider)
        }
    }
}
