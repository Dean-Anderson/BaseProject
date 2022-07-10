//
//  APIClient.swift
//  BaseProject (iOS)
//
//  Created by dean.anderson on 2022/07/09.
//

import Foundation
import Combine

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}

enum APIError: Error {
    case urlRequestCreateFailed
    case decodeFail
    case unexpected
}

protocol DefinedError: Error {
    init(error: Error)
    init(data: Data)
    init(urlError: URLError)
}

protocol APIClient {
    associatedtype Data: Decodable
    associatedtype ClientDefinedError: DefinedError
    
    var domain: String { get }
    var headers: [String: String]? { get }
    var commonHeaders: [String: String]? { get }
    var path: String? { get }
    var method: HttpMethod { get }
    var session: URLSession { get }
    var decoder: JSONDecoder { get }
    
    func request() -> AnyPublisher<Data, Error>
}

private extension APIClient {
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
    
    func request() -> AnyPublisher<Data, Error> {
        guard let request = createURLRequest() else { return Fail(error: APIError.urlRequestCreateFailed).eraseToAnyPublisher() }
        
        return session.dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .mapError { ClientDefinedError(urlError: $0) }
            .eraseToAnyPublisher()
            .flatMap({ (data, response) -> AnyPublisher<Data, Error> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: APIError.unexpected).eraseToAnyPublisher()
                }
                
                if (200...299).contains(response.statusCode) {
                    return Just(data)
                        .decode(type: Data.self, decoder: decoder)
                        .mapError { _ in APIError.decodeFail }
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: ClientDefinedError(data: data)).eraseToAnyPublisher()
                }
            })
            .eraseToAnyPublisher()
    }
}
