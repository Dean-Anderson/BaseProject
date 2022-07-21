//
//  JSONLoader.swift
//  BaseProject
//
//  Created by dean.anderson on 2022/07/15.
//

import Foundation

protocol JSONLoadable {
    var fileName: String { get }
    var decodableType: Decodable.Type { get }
    func loadData() -> Data?
    func load<T: Decodable>() -> T?
}

enum JSONAssets {
}

//extension JSONAssets: JSONLoadable {
//    var fileName: String {
//        switch self {
//        }
//    }
//    
//    var decodableType: Decodable.Type {
//        switch self {
//        }
//    }
//    
//    func loadData() -> Data? {
//        guard let file = Bundle.main.url(forResource: fileName, withExtension: nil) else { return nil }
//        return try? Data(contentsOf: file)
//    }
//    
//    func load<T: Decodable>() -> T? {
//        guard let data = loadData() else { return nil }
//        
//        let decoder = JSONDecoder()
//        return try? decoder.decode(T.self, from: data)
//    }
//}
