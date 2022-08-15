//
//  SettingFooterItemView.swift
//  BaseProject (iOS)
//
//  Created by dean.anderson on 2022/07/22.
//

import SwiftUI

struct SettingFooterItemView: View {
    let drawable: SettingFooterItemViewDrawable
    
    var body: some View {
        VStack(alignment: .center, spacing: Metric.verticalSpacing) {
            Image(uiImage: drawable.image)
            
            Text(drawable.title)
                .font(.set(.title))
                .foregroundColor(.set(.heavyGray))
        }
    }
}

private extension SettingFooterItemView {
    enum Metric {
        static let verticalSpacing: CGFloat = 5
    }
}

struct SettingFooterItemView_Previews: PreviewProvider {
    static var previews: some View {
        SettingFooterItemView(drawable: SettingFooterItemViewDTO(image: ImageAssets.bell.uiImage, title: "test"))
    }
}

protocol SettingFooterItemViewDrawable {
    var id: String { get }
    var image: UIImage { get }
    var title: String { get }
}

struct SettingFooterItemViewDTO: SettingFooterItemViewDrawable, Identifiable {
    var id: String { title }
    let image: UIImage
    let title: String
}
