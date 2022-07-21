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
    case decodeFail
    case unexpected
    case urlError(URLError)
    case data(Data)
}

public protocol APIClient {
    var domain: String { get }
    var headers: [String: String]? { get }
    var commonHeaders: [String: String]? { get }
    var path: String? { get }
    var method: HttpMethod { get }
    var session: URLSession { get }
    var decoder: JSONDecoder { get }
    
    func request() -> AnyPublisher<Data, APIError>
    
    var mock: Data? { get }
    func requestMock() -> AnyPublisher<Data, APIError>
}

public extension APIClient {
    var session: URLSession { URLSession.shared }
    
    var decoder: JSONDecoder { JSONDecoder() }
    
    func createURLRequest() -> URLRequest? {
        let fullPath = "\(domain)\(path ?? ""))"
        
        guard var components = URLComponents(string: fullPath) else {
            return nil
        }
    
        if method == .get {
            components.queryItems = headers?.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = components.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if method != .get {
            headers?.forEach {
                request.setValue($0.value, forHTTPHeaderField: $0.key)
            }
            
            commonHeaders?.forEach {
                request.setValue($0.value, forHTTPHeaderField: $0.key)
            }
        }
        
        return request
    }
    
    func request() -> AnyPublisher<Data, APIError> {
        guard let request = createURLRequest() else { return Fail(error: APIError.urlRequestCreateFailed).eraseToAnyPublisher() }
        
        return session.dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .mapError { APIError.urlError($0) }
            .eraseToAnyPublisher()
            .flatMap({ (data, response) -> AnyPublisher<Data, APIError> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: APIError.unexpected).eraseToAnyPublisher()
                }
                
                if (200...299).contains(response.statusCode) {
                    return Just(data)
                        .decode(type: Data.self, decoder: decoder)
                        .mapError { _ in APIError.decodeFail }
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: APIError.data(data)).eraseToAnyPublisher()
                }
            })
            .eraseToAnyPublisher()
    }
    
    func requestMock() -> AnyPublisher<Data, APIError> {
        guard let mock = mock else { return Empty<Data, APIError>().eraseToAnyPublisher() }
        return Just(mock).mapError { _ in APIError.unexpected }.eraseToAnyPublisher()
    }
}
