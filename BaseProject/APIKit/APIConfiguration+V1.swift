//
//  APIConfiguration+V1.swift
//  APIKit
//
//  Created by dean.anderson on 2022/09/19.
//

public final class AppAPIConfiguration: APIConfiguration {
    public let domain: String = ""
    public let headers: [String: String]? = [:]
    public let session: URLSession = .shared
    
    public static let shared: APIConfiguration = AppAPIConfiguration()
}
