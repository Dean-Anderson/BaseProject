//
//  SettingFooterView.swift
//  BaseProject (iOS)
//
//  Created by dean.anderson on 2022/07/22.
//

import SwiftUI

struct SettingFooterView: View {
    let drawables: [SettingFooterItemViewDrawable]
    
    var body: some View {
        
        HStack(alignment: .center, spacing: Metric.horizontalSpacing) {
            ForEach(drawables, id: \.id) { drawable in
                HStack {
                    Spacer()
                    SettingFooterItemView(drawable: drawable)
                    Spacer()
                }
            }
        }
        .padding(Metric.padding)
        .foregroundColor(ColorAssets.lightGray.color)
    }
}

private extension SettingFooterView {
    enum Metric {
        static let horizontalSpacing: CGFloat = 10
        static let padding: EdgeInsets = .init(top: 10, leading: 20, bottom: 10, trailing: 20)
    }
}

struct SettingFooterView_Previews: PreviewProvider {
    static var previews: some View {
        SettingFooterView(drawables: [SettingFooterItemViewDTO(image: ImageAssets.speaker.uiImage, title: "공지사항"),
                                      SettingFooterItemViewDTO(image: ImageAssets.star.uiImage, title: "이벤트")])

    }
}

