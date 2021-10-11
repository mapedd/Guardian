//
//  XCTestCase+Combine.swift
//  GuardianTests
//
//  Created by Tomasz Kuzma on 08/10/2021.
//

import Foundation
import Combine
import XCTest

extension XCTestCase {

    func waitFailure<T: Publisher>(for publisher: T,
        timeout: TimeInterval = 10,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> T.Failure {

        var result: Result<T.Output, T.Failure>?
        let expectation = self.expectation(description: "Awaiting publisher")

        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    result = .failure(error)
                case .finished:
                    break
                }

                expectation.fulfill()
            },
            receiveValue: { value in
                result = .success(value)
            }
        )


        waitForExpectations(timeout: timeout)
        cancellable.cancel()


        let unwrappedError = try XCTUnwrap(
            result,
            "Awaited publisher did not produce any output",
            file: file,
            line: line
        )

        switch unwrappedError {
        case .failure(let error):
            return error
        case .success(_):
            XCTFail("expected error to be result")
            fatalError()
        }
    }

    func wait<T: Publisher>(for publisher: T,
        timeout: TimeInterval = 10,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> T.Output {

        var result: Result<T.Output, Error>?
        let expectation = self.expectation(description: "Awaiting publisher")

        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    result = .failure(error)
                case .finished:
                    break
                }

                expectation.fulfill()
            },
            receiveValue: { value in
                result = .success(value)
            }
        )


        waitForExpectations(timeout: timeout)
        cancellable.cancel()


        let unwrappedResult = try XCTUnwrap(
            result,
            "Awaited publisher did not produce any output",
            file: file,
            line: line
        )

        return try unwrappedResult.get()
    }
}
