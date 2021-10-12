//
//  Publisher+Testing.swift
//  TestingExtensions
//
//  Created by Tomasz Kuzma on 12/10/2021.
//

import Foundation
import Combine

extension Published.Publisher {
    public func collectNext(_ count: Int) -> AnyPublisher<[Output], Never> {
        self.dropFirst()
            .collect(count)
            .first()
            .eraseToAnyPublisher()
    }
}
