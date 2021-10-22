//
//  Network.swift
//  Guardian
//
//  Created by Tomasz Kuzma on 06/10/2021.
//

import Foundation
import Combine

public class GuardianAPI {

    public enum Error: LocalizedError, Equatable {
        case unreachable(URL)
        case invalidResponse
        case wrongJSONStructure
        
        public var errorDescription: String? {
            switch self {
            case .invalidResponse: return "Cannot decode data."
            case .unreachable(let url): return "\(url.absoluteString) is unreachable."
            case .wrongJSONStructure: return "adjust your Decodable structure of the response"
            }
        }
    }

    private let apiQueue = DispatchQueue(label: "API.guardian",
                                         qos: .default)
    
    private let decoder = JSONDecoder()
    
    private let apiProvider: APIProvider
    private let endpoint: EndPoint
    
    public init(apiProvider: APIProvider,
                endpoint: EndPoint) {
        self.apiProvider = apiProvider
        self.endpoint = endpoint
    }
    
    public func recipes() -> AnyPublisher<GuardianResponse, Error> {
        return apiProvider
            .apiResponse(for: endpoint.url)
            .receive(on: apiQueue)
            .map(\.data)
            .decode(type: GuardianResponse.self, decoder: decoder)
            .mapError { error in
                switch error {
                case is URLError:
                    return Error.unreachable(self.endpoint.url)
                case is DecodingError:
                    return Error.wrongJSONStructure
                default: return Error.invalidResponse
                }
            }
            .eraseToAnyPublisher()
    }
    
}

