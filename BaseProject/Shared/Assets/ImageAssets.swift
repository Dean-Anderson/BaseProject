//
//  ImageAssets.swift
//  BaseProject
//
//  Created by dean.anderson on 2022/07/18.
//

import Foundation
import SwiftUI

enum ImageName {
    case name(String)
    case systemName(String)
    
    var uiImage: UIImage {
        switch self {
        case let .name(name):
            return UIImage(named: name) ?? UIImage()
            
        case let .systemName(name):
            return UIImage(systemName: name) ?? UIImage()
        }
    }
    
    var image: Image {
        return Image(uiImage: uiImage)
    }
}

protocol ImageLoadable {
    var image: Image { get }
    var uiImage: UIImage { get }
    var name: ImageName { get }
}

enum ImageAssets: String {
    case house
    case houseFill = "house.fill"
    case ellipsis = "ellipsis.rectangle"
    case ellipsisFill = "ellipsis.rectangle.fill"
    case car
    case chart = "chart.line.uptrend.xyaxis"
    case roundArrow = "arrow.uturn.backward"
    case plus
    case mic
    case creditcard
    case note = "note.text"
    case shield = "checkerboard.shield"
    case speaker
    case star
    case bubble = "bubble.right"
    case person
    case bell
}

extension ImageAssets: ImageLoadable {
    var image: Image { name.image }
    
    var uiImage: UIImage { name.uiImage }
    
    var name: ImageName { .systemName(rawValue) }
}
