//
//  APIProvider.swift
//  Guardian
//
//  Created by Tomasz Kuzma on 08/10/2021.
//

import Foundation
import Combine

protocol APIProvider {
    typealias APIResponse = URLSession.DataTaskPublisher.Output
    func apiResponse(for url: URL) -> AnyPublisher<APIResponse, URLError>
}

extension URLSession: APIProvider {
    func apiResponse(for url: URL) -> AnyPublisher<APIResponse, URLError> {
        return dataTaskPublisher(for: url).eraseToAnyPublisher()
    }
}
