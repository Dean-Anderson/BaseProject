//
//  TabBarView.swift
//  BaseProject
//
//  Created by dean.anderson on 2022/07/18.
//

import SwiftUI

struct TabBarView: View {
    @Binding var builders: [TabBarItemBuilder]
    let tapSelected: ((TabBarItem) -> ())?
    
    var body: some View {
        HStack(alignment: .center, spacing: Metric.spacing) {
            Spacer()
            ForEach(builders.indices) { offset in
                TabBarItemView(builder: $builders[offset])
                    .onTapGesture {
                        tapSelected?(builders[offset].tabBarItem)
                    }
                Spacer()
            }
        }
        .padding(Metric.padding)
        .frame(width: nil, height: Metric.height, alignment: .center)
        .background(Color.white)
    }
}

fileprivate extension TabBarView {
    enum Metric {
        static let spacing: CGFloat = 0
        static let padding: EdgeInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
        static let height: CGFloat = 56
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        let builders = TabBarItem.allCases.map { TabBarItemBuilder(tabBarItem: $0, isSelected: true) }
        TabBarView(builders: .constant(builders)) { _ in }
    }
}
