//
//  ImageAssets.swift
//  BaseProject
//
//  Created by dean.anderson on 2022/07/18.
//

import Foundation
import SwiftUI

protocol ImageLoadable {
    var image: Image { get }
    var uiImage: UIImage { get }
}

enum ImageAssets: String {
    case ic_24_tab_home_off
    case ic_24_tab_home_on
    case ic_24_tab_more_off
    case ic_24_tab_more_on
}

extension ImageAssets: ImageLoadable {
    var image: Image { Image(rawValue) }
    var uiImage: UIImage { UIImage(named: rawValue) ?? UIImage() }
}
