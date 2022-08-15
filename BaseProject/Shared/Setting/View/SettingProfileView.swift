//
//  SettingProfileView.swift
//  BaseProject (iOS)
//
//  Created by dean.anderson on 2022/07/22.
//

import SwiftUI

struct SettingProfileView: View {
    let drawable: SettingProfileViewDrawable
    
    var body: some View {
        HStack(alignment: .center, spacing: Metric.horizontalSpacing) {
            Image(uiImage: drawable.image)
                .frame(width: Metric.imageSize, height: Metric.imageSize)
                .background(Color.set(.lightGray))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: Metric.verticalSpacing) {
                Text(drawable.name)
                    .font(.set(.title))
                    .foregroundColor(.set(.heavyGray))
                
                Text(drawable.email)
                    .font(.set(.desc))
                    .foregroundColor(.set(.gray))
            }
            
            Spacer()
            
            Image(uiImage: ImageAssets.bell.uiImage)
        }
        .padding(Metric.padding)
        .foregroundColor(.set(.lightGray))
        .listRowInsets(EdgeInsets())
    }
}

private extension SettingProfileView {
    enum Metric {
        static let imageSize: CGFloat = 60
        static let horizontalSpacing: CGFloat = 10
        static let verticalSpacing: CGFloat = 5
        static let padding: EdgeInsets = .init(top: 10, leading: 20, bottom: 10, trailing: 20)
    }
}

struct SettingProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingProfileView(drawable: SettingProfileViewDTO())
                .previewLayout(.fixed(width: 320, height: 80))
        }
    }
}

protocol SettingProfileViewDrawable {
    var image: UIImage { get }
    var name: String { get }
    var email: String { get }
}

struct SettingProfileViewDTO: SettingProfileViewDrawable {
    var image: UIImage = ImageAssets.person.uiImage
    var name: String = "유저"
    var email: String = "test@kakao.com"
}
