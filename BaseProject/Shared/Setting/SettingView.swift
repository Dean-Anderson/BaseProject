//
//  SettingView.swift
//  BaseProject
//
//  Created by dean.anderson on 2022/07/19.
//

import SwiftUI

struct SettingView: View {
    @StateObject private var viewModel: SettingViewModel = .init()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.dataSource) { section in
                    Section {
                        ForEach(section.rowItems) { row in
                            switch row {
                            case let .profile(profile):
                                SettingProfileView(drawable: profile)
                                
                            case let .common(drawable):
                                NavigationLink(destination: WidgetView()) {
                                    SettingCommonView(drawable: drawable)
                                }
                                
                            case let .footer(drawables):
                                SettingFooterView(drawables: drawables)
                            }
                        }
                    }
                }
            }
            .padding(EdgeInsets())
            .onAppear(perform: {
                UITableView.appearance().separatorColor = .clear // separator color
            })
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

private extension SettingView {
    enum Metric {
        static let spacing: CGFloat = 10
        static let sectionPadding: CGFloat = 20
    }
}
