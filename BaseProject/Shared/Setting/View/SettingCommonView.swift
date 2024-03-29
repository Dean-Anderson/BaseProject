//
//  SettingCommonView.swift
//  BaseProject (iOS)
//
//  Created by dean.anderson on 2022/07/21.
//

import SwiftUI

struct SettingCommonView: View {
    let drawable: SettingCommonViewDrawable
    
    var body: some View {
        HStack(alignment: .center, spacing: Metric.horizontalSpacing) {
            if let image = drawable.image {
                Image(uiImage: image)
            }
            
            VStack(alignment: .leading, spacing: Metric.verticalSpacing) {
                Text(drawable.title)
                    .font(.set(.title))
                    .foregroundColor(.set(.heavyGray))
                
                if let desc = drawable.desc {
                    Text(desc)
                        .font(.set(.desc))
                        .foregroundColor(.set(.gray))
                }
            }
            
            Spacer()
            
            if let postfix = drawable.postfix {
                Text(postfix)
                    .font(.set(.title))
                    .foregroundColor(.set(.gray))
            }
            
            Text(">")
                .font(.set(.title))
                .foregroundColor(.set(.heavyGray))
        }
        .padding(Metric.padding)
        .foregroundColor(.set(.lightGray))
        .listRowInsets(EdgeInsets())
    }
}

private extension SettingCommonView {
    enum Metric {
        static let horizontalSpacing: CGFloat = 10
        static let verticalSpacing: CGFloat = 5
        static let padding: EdgeInsets = .init(top: 10, leading: 20, bottom: 10, trailing: 20)
    }
}

struct SettingCommonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingCommonView(drawable: SettingCommonViewDTO(title: "Title"))
                .previewLayout(.fixed(width: 320, height: 50))
            
            SettingCommonView(drawable: SettingCommonViewDTO(image: ImageAssets.house.uiImage,
                                                             title: "Title"))
            .previewLayout(.fixed(width: 320, height: 50))
            
            SettingCommonView(drawable: SettingCommonViewDTO(image: ImageAssets.house.uiImage,
                                                             title: "Title",
                                                             desc: "Desc"))
            .previewLayout(.fixed(width: 320, height: 50))
            
            SettingCommonView(drawable: SettingCommonViewDTO(image: ImageAssets.house.uiImage,
                                                             title: "Title",
                                                             desc: "Desc",
                                                             postfix: "postfix"))
            .previewLayout(.fixed(width: 320, height: 50))
        }
    }
}

protocol SettingCommonViewDrawable {
    var image: UIImage? { get }
    var title: String { get }
    var desc: String? { get }
    var postfix: String? { get }
    var isNew: Bool { get }
}

struct SettingCommonViewDTO: SettingCommonViewDrawable {
    var image: UIImage? = nil
    let title: String
    var desc: String? = nil
    var postfix: String? = nil
    var isNew: Bool = false
}
