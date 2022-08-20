//
//  WidgetViewModel.swift
//  BaseProject (iOS)
//
//  Created by dean.anderson on 2022/08/15.
//

import Foundation
import SwiftUI

final class WidgetViewModel: ObservableObject {
    @Published var dataSource: [WidgetSectionItem] = [WidgetSectionItem(section: .locations,
                                                                         rowItems: [WidgetRow.location(WidgetLocationViewDTO(title: "장소 1", desc: "설명")),
                                                                                    WidgetRow.location(WidgetLocationViewDTO(title: "장소 2", desc: "설명")),
                                                                                    WidgetRow.location(WidgetLocationViewDTO(title: "장소 3", desc: "설명")),
                                                                                    WidgetRow.location(WidgetLocationViewDTO(title: "장소 4", desc: "설명")),
                                                                                    WidgetRow.location(WidgetLocationViewDTO(title: "장소 5", desc: "설명"))])]
    var sectionRow: (Int, Int)?
    
    func remove(section: Int, row: Int) {
        var newDataSource: [WidgetSectionItem] = []
        
        Array(0..<dataSource.count).forEach {
            if $0 == section {
                let sectionItem = dataSource[$0]
                let rowItems = sectionItem.rowItems.enumerated().compactMap { $0.offset == row ? nil : $0.element }
                let newSectionItem = WidgetSectionItem(section: sectionItem.section, rowItems: rowItems)
                newDataSource.append(newSectionItem)
            } else {
                newDataSource.append(self.dataSource[$0])
            }
        }
        
        self.dataSource = newDataSource
    }
    
    // section 간 교환은 불가
    func move(section: Int, from: Int, to: Int) {
        Array(0..<dataSource.count).forEach {
            if $0 == section {
                let sectionItem = dataSource[section]
                var rowItems = sectionItem.rowItems
                rowItems.swapAt(from, to)
                dataSource.remove(at: section)
                dataSource.insert(.init(section: sectionItem.section, rowItems: rowItems), at: section)
            }
        }
    }
}

struct WidgetViewDropDelegate: DropDelegate {
    
    let sectionRow: (Int, Int)
    let viewModel: WidgetViewModel
    
    func performDrop(info: DropInfo) -> Bool {
        print("performDrop")
        return true
    }
    
    func dropEntered(info: DropInfo) {
        print("dropEntered")
        guard let viewModelSectionRow = viewModel.sectionRow else { return }
        
        let fromSection = viewModel.dataSource[viewModelSectionRow.0]
        let toSection = viewModel.dataSource[sectionRow.0]
        
        guard !fromSection.rowItems.enumerated().filter({ $0.offset == viewModelSectionRow.1 }).isEmpty else { return }
        guard let to = toSection.rowItems.enumerated().filter({ $0.offset == sectionRow.1 }).map({ $0.offset }).first else { return }
        
        if viewModelSectionRow.1 != to {
            withAnimation(.default){
                viewModel.move(section: sectionRow.0, from: viewModelSectionRow.1, to: to)
            }
        }
    }

    func dropUpdated(info: DropInfo) -> DropProposal? {
        print("dropUpdated")
        return DropProposal(operation: .move)
    }
}

enum WidgetSection: String, CaseIterable {
    case locations
}

enum WidgetRow: Identifiable {
    case location(WidgetLocationViewDrawable)
    
    var id: String {
        switch self {
        case let .location(drawable):
            return drawable.title
        }
    }
}

struct WidgetSectionItem: Identifiable {
    var id: String { section.rawValue }
    let section: WidgetSection
    let rowItems: [WidgetRow]
}
