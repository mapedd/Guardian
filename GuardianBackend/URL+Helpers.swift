//
//  URL+Helpers.swift
//  GuardianBackend
//
//  Created by Tomasz Kuzma on 12/10/2021.
//

import Foundation

extension URL {
    func appending(_ filters: [Filter]) -> URL {
        let items = filters.map {
            $0.queryItem
        }
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
            fatalError("invalid url \(self)")
        }
        if components.queryItems == nil {
            components.queryItems = []
        }
        components.queryItems?.append(contentsOf: items)
        guard let validURL = components.url else {
            fatalError("invalid URL from \(String(describing: components))")
        }
        return validURL
    }
}
