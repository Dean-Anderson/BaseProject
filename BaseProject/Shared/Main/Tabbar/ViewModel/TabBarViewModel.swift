//
//  TabBarViewModel.swift
//  BaseProject
//
//  Created by dean.anderson on 2022/07/19.
//

import Foundation

final class TabBarViewModel: ObservableObject {
    @Published var selection: String
    @Published var builders: [TabBarItemBuilder]
    
    init(items: [TabBarItem]) {
        let selection = items.first?.id ?? ""
        self.builders = Self.createBuilders(items: items, selection: selection)
        self.selection = selection
    }
    
    func set(items: [TabBarItem], selection: String) {
        self.builders = Self.createBuilders(items: items, selection: selection)
        self.selection = selection
    }

    func select(tag: String) {
        if builders.map({ $0.id }).contains(tag) {
            self.selection = tag
            self.builders = Self.createBuilders(builders: builders, selection: selection)
        }
    }
    
    func select(item: TabBarItem) {
        select(tag: item.rawValue)
    }
}

private extension TabBarViewModel {
    static func createBuilders(items: [TabBarItem], selection: String) -> [TabBarItemBuilder] {
        items.map { TabBarItemBuilder(tabBarItem: $0, isSelected: $0.id == selection) }
    }
    
    static func createBuilders(builders: [TabBarItemBuilder], selection: String) -> [TabBarItemBuilder] {
        builders.map { TabBarItemBuilder(tabBarItem: $0.tabBarItem, isSelected: $0.id == selection) }
    }
}
