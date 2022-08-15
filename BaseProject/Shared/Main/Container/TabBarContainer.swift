//
//  TabBarContainer.swift
//  BaseProject
//
//  Created by dean.anderson on 2022/07/18.
//

import SwiftUI

struct TabBarContainer: View {
    @StateObject private var viewModel: TabBarViewModel
    
    init(items: [TabBarItem]) {
        self._viewModel = .init(wrappedValue: .init(items: items))
    }

    var body: some View {
        ZStack {
            TabView(selection: $viewModel.selection) {
                ForEach(viewModel.builders) { builder in
                    builder.view()
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .ignoresSafeArea()
            .onAppear {
                UIScrollView.appearance().isScrollEnabled = false // tabView page scroll 막기
            }
            
            VStack {
                Spacer()   
                TabBarView(builders: $viewModel.builders) { viewModel.select(item: $0) }
            }
        }
    }
}

struct TabBarContainer_Previews: PreviewProvider {
    static var previews: some View {
        TabBarContainer(items: TabBarItem.allCases)
            .previewInterfaceOrientation(.portrait)
    }
}
