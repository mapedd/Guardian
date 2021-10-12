//
//  AppExtensions.swift
//  Guardian
//
//  Created by Tomasz Kuzma on 12/10/2021.
//

import Foundation
import SwiftUI
import GuardianBackend

extension App {

    var env: [String:String] {
        ProcessInfo.processInfo.environment
    }

    var mockedNetwork: Bool {
        env["mockNetwork"] != nil
    }

    var isTesting: Bool {
        env["XCTestConfigurationFilePath"] != nil
    }

    var showingDetails: Bool {
        env["showDetailScreen"] != nil
    }

    var provider : APIProvider {
        if mockedNetwork {
            return MockAPIProvider()
        } else {
            return URLSession.shared
        }
    }
}
