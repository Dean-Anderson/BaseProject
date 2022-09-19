//
//  APIClient.swift
//  BaseProject (iOS)
//
//  Created by dean.anderson on 2022/07/09.
//

import Foundation
import Combine

public enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}

public enum APIError: Error {
    case urlRequestCreateFailed
    case unexpected
    case decodeFailure
    case urlError(URLError)
    case data(Data)
}

public protocol APIProvidier {
    var configuration: APIConfiguration { get }
    var decoder: JSONDecoder { get }
    var path: String? { get }
    var method: HttpMethod { get }
    var session: URLSession { get }
    var combine: CombineRequest<Self> { get }
    var async: AsyncRequest<Self> { get }
}

public extension APIProvidier {
    var configuration: APIConfiguration { AppAPIConfiguration.shared }
    
    var decoder: JSONDecoder { .init() }
    
    func createURLRequest() -> URLRequest? {
        let fullPath = "\(configuration.domain)\(path ?? ""))"
        
        guard var components = URLComponents(string: fullPath) else {
            return nil
        }
    
        if method == .get {
            components.queryItems = configuration.headers?.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = components.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if method != .get {
            configuration.headers?.forEach {
                request.setValue($0.value, forHTTPHeaderField: $0.key)
            }
        }
        
        return request
    }
    
    var combine: CombineRequest<Self> { CombineRequest(base: self) }
    
    var async: AsyncRequest<Self> { AsyncRequest(base: self) }
    
    static func processResponse(data: Data, response: URLResponse) -> Result<Data, APIError> {
        guard let response = response as? HTTPURLResponse else {
            return .failure(.unexpected)
        }
        
        if (200...299).contains(response.statusCode) {
            return .success(data)
        } else {
            return .failure(.data(data))
        }
    }
}

public struct CombineRequest<Base> {
    private let base: Base
    
    init(base: Base) {
        self.base = base
    }
}

public extension CombineRequest where Base: APIProvidier {
    func request<DTO: Decodable>() -> AnyPublisher<DTO, APIError> {
        guard let request = base.createURLRequest() else { return Fail(error: APIError.urlRequestCreateFailed).eraseToAnyPublisher() }
        
        let decoder = base.decoder
        
        return base.session.dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .mapError { APIError.urlError($0) }
            .eraseToAnyPublisher()
            .flatMap({ (data, response) -> AnyPublisher<DTO, APIError> in
                let result = type(of: base).processResponse(data: data, response: response)
                
                switch result {
                case let .success(data):
                    return Just(data)
                        .setFailureType(to: APIError.self)
                        .decode(type: DTO.self, decoder: decoder)
                        .mapError({ _ in
                            APIError.decodeFailure
                        })
                        .eraseToAnyPublisher()
                    
                case let .failure(error):
                    return Fail(error: error).eraseToAnyPublisher()
                }
            })
            .eraseToAnyPublisher()
    }
}

public struct AsyncRequest<Base> {
    private let base: Base
    
    init(base: Base) {
        self.base = base
    }
}

public extension AsyncRequest where Base: APIProvidier {
    func request<DTO: Decodable>() async throws -> DTO {
        guard let request = base.createURLRequest() else { throw APIError.urlRequestCreateFailed }
        
        let (data, response) = try await base.session.data(for: request)
        let result = type(of: base).processResponse(data: data, response: response)

        switch result {
        case let .success(data):
            do {
                return try base.decoder.decode(DTO.self, from: data)
            } catch {
                throw APIError.decodeFailure
            }
            
        case let .failure(error):
            throw error
        }
    }
}
