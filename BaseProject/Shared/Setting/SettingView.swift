//
//  SettingView.swift
//  BaseProject
//
//  Created by dean.anderson on 2022/07/19.
//

import SwiftUI

struct SettingView: View {
    @ObservedObject private var viewModel: SettingViewModel = .init()
    
    var body: some View {
        List {
            ForEach(viewModel.dataSource) { section in
                Section {
                    ForEach(section.rowItems) { row in
                        switch row {
                        case let .common(drawable):
                            SettingCommonView(drawable: .constant(drawable))
                        }
                    }
                }
            }
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
    }
}
