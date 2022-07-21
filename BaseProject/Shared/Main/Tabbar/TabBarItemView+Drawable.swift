//
//  TabBarItemView+Drawable.swift
//  BaseProject
//
//  Created by dean.anderson on 2022/07/18.
//

import Foundation
import UIKit
import SwiftUI

protocol TabBarItemDrawable {
    var title: String { get }
    var image: UIImage { get }
    var isSelected: Bool { get }
}

enum TabBarItem: String, CaseIterable, Identifiable {
    case home
    case setting
    
    var id: String { rawValue }
}

struct TabBarItemBuilder: TabBarItemDrawable, Identifiable {
    var id: String { tabBarItem.id }
    let tabBarItem: TabBarItem
    let isSelected: Bool
    
    var title: String {
        switch tabBarItem {
        case .home:    return "홈"
        case .setting: return "설정"
        }
    }
    
    var image: UIImage {
        switch tabBarItem {
        case .home:    return isSelected ? ImageAssets.ic_24_tab_home_on.uiImage : ImageAssets.ic_24_tab_home_off.uiImage
        case .setting: return isSelected ? ImageAssets.ic_24_tab_more_on.uiImage : ImageAssets.ic_24_tab_more_off.uiImage
        }
    }

    @ViewBuilder
    func view() -> some View {
        switch tabBarItem {
        case .home:     MapView(coordinate: .init(latitude: 34.011_286, longitude: -116.166_868)).tag(id)
        case .setting:  SettingView().tag(id)
        }
    }
}
