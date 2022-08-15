//
//  ColorAssets.swift
//  BaseProject (iOS)
//
//  Created by dean.anderson on 2022/07/21.
//

import UIKit
import SwiftUI

protocol ColorLoadable {
    var name: String { get }
    var uiColor: UIColor { get }
    var color: Color { get }
}

enum ColorAssets: String, CaseIterable {
    case beige
    case gray
    case heavyGray
    case lightGray
    case pink
}

extension ColorAssets: ColorLoadable {
    var name: String { rawValue }
    var uiColor: UIColor { UIColor(named: name) ?? UIColor.red }
    var color: Color { Color(uiColor: uiColor)  }
}

extension UIColor {
    static func set(_ assets: ColorAssets) -> UIColor {
        assets.uiColor
    }
}

extension Color {
    static func set(_ assets: ColorAssets) -> Color {
        assets.color
    }
}
