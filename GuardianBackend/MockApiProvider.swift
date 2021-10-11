//
//  Mocks.swift
//  GuardianTests
//
//  Created by Tomasz Kuzma on 07/10/2021.
//

import Foundation
import Combine

public class MockAPIProvider: APIProvider {

    let returnError: Bool
    public init(returnError: Bool = false) {
        self.returnError = returnError
    }
    
    class Foo {

    }

    func urlResponse(for url:URL) -> URLResponse {
        HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
    func defaultResponse(url: URL) -> (data:Data,response: URLResponse) {

        let path = bundle.path(forResource: "sampleFull", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        return (data, urlResponse(for: url))
    }

    let bundle = Bundle(for: Foo.self)

    public var resultToReturn: Result<Data, URLError>?
    public var urlsInserted = [URL]()
    
    public func apiResponse(for url: URL) -> AnyPublisher<APIResponse, URLError> {

        urlsInserted.append(url)

        if let resultToReturn = resultToReturn {
            switch resultToReturn {
            case .success(let data):
                return Just((data: data, response: urlResponse(for: url)))
                    .setFailureType(to: URLError.self)
                    .eraseToAnyPublisher()
            case .failure(let error):
                let error = URLError(URLError.Code.badServerResponse, userInfo: [:] )
                let result = Result<APIResponse, URLError>.failure(error)
                return result.publisher.eraseToAnyPublisher()
            }
        }
        else {
            if self.returnError {
                let error = URLError(URLError.Code.badServerResponse)
                let result = Result<APIResponse, URLError>.failure(error)
                return result.publisher.eraseToAnyPublisher()
            } else {
                let response = defaultResponse(url: url)
                return Just((data: response.data, response: response.response))
                    .setFailureType(to: URLError.self)
                    .eraseToAnyPublisher()
            }
        }
    }
}
