//
//  Image+Extension.swift
//  BaseProject
//
//  Created by dean.anderson on 2022/07/18.
//

import SwiftUI

extension Image {
    init(_ assets: ImageAssets) {
        self.init(uiImage: assets.uiImage)
    }
}
