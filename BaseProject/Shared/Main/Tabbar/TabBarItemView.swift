//
//  TabBarItemView.swift
//  BaseProject
//
//  Created by dean.anderson on 2022/07/18.
//

import SwiftUI

struct TabBarItemView: View {
    @Binding var builder: TabBarItemBuilder
    
    var body: some View {
        VStack(alignment: .center, spacing: Metric.spacing) {
            Image(uiImage: builder.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text(builder.title)
                .setFont(.title)
                .multilineTextAlignment(.center)
        }
        .padding(Metric.padding)
    }
}

private extension TabBarItemView {
    enum Metric {
        static let spacing: CGFloat = 10
        static let padding: EdgeInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
    }
}

struct TabBarItemView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(TabBarItem.allCases) { item in
            
            TabBarItemView(builder: .constant(TabBarItemBuilder(tabBarItem: item, isSelected: true)))
                .previewLayout(.fixed(width: 150, height: 150))
            
            TabBarItemView(builder: .constant(TabBarItemBuilder(tabBarItem: item, isSelected: false)))
                .previewLayout(.fixed(width: 150, height: 150))
        }
    }
}

