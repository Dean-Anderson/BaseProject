//
//  WidgetView.swift
//  BaseProject (iOS)
//
//  Created by dean.anderson on 2022/08/15.
//

import SwiftUI

// List에서는 드래그 앤 드랍이 구현되지 않는다... scrollView로 해야만 함
struct WidgetView: View {
    @StateObject private var viewModel: WidgetViewModel = .init()
    
    var body: some View {
        ScrollView {
            ForEach(Array(viewModel.dataSource.enumerated()), id: \.offset) { sectionOffset, section in
//                Section {
                    ForEach(Array(section.rowItems.enumerated()), id: \.offset) { rowOffset, row in
                        switch row {
                        case let .location(drawable):
                            WidgetLocationView(drawable: drawable)
                                .onDrag {
                                    self.viewModel.sectionRow = (sectionOffset, rowOffset)
                                    return NSItemProvider(object: row.id as NSString)
                                }
                                .onDrop(of: [.text], delegate: WidgetViewDropDelegate(sectionRow: (sectionOffset, rowOffset), viewModel: viewModel))
                        }
                    }
                    .onDelete { indexSet in
                        guard let row = indexSet.first else { return }
                        self.viewModel.remove(section: sectionOffset, row: row)
                    }
//                }
            }
        }
        .padding(EdgeInsets())
        .onAppear(perform: {
            UITableView.appearance().separatorColor = .clear // separator color
        })
    }
}

struct WidgetView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetView()
    }
}

private extension WidgetView {
    enum Metric {
        static let spacing: CGFloat = 10
        static let sectionPadding: CGFloat = 20
    }
}

