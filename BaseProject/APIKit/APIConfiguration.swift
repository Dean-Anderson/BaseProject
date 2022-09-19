//
//  APIConfiguration.swift
//  APIKit
//
//  Created by dean.anderson on 2022/09/19.
//

public protocol APIConfiguration {
    var domain: String { get }
    var headers: [String: String]? { get }
    var session: URLSession { get }
    
    static func processResponse(data: Data, response: URLResponse) -> Result<Data, APIError>
}

extension APIConfiguration {
    public static func processResponse(data: Data, response: URLResponse) -> Result<Data, APIError> {
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
