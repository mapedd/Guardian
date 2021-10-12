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
    var mockedNetwork: Bool {
        return ProcessInfo.processInfo.environment["mockNetwork"] != nil
    }

    var isTesting: Bool {
        ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    }

    var provider : APIProvider {
        if mockedNetwork {
            return MockAPIProvider()
        } else {
            return URLSession.shared
        }
    }
}
