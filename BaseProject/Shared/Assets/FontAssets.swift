//
//  FontAssets.swift
//  BaseProject
//
//  Created by dean.anderson on 2022/07/19.
//

import Foundation
import SwiftUI

protocol FontLoadable {
    var name: String { get }
    var size: CGFloat { get }
    var font: Font? { get }
}

enum FontAssets: String, CaseIterable {
    case title
    case desc
}

extension FontAssets: FontLoadable {
    var name: String {
        switch self {
        case .title:       return "SFProDisplay-Regular"
        case .desc:        return "SFProDisplay-Regular"
        }
    }
    
    var size: CGFloat {
        switch self {
        case .title:        return 11
        case .desc:         return 9
        }
    }
    
    var font: Font? {
        Font.custom(name, fixedSize: size)
    }
}

extension Text {
    func setFont(_ assets: FontAssets) -> Text {
        font(assets.font)
    }
}
