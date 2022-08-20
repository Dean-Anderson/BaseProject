//
//  WidgetLocationView.swift
//  BaseProject (iOS)
//
//  Created by dean.anderson on 2022/08/15.
//

import SwiftUI

struct WidgetLocationView: View {
    let drawable: WidgetLocationViewDrawable
    
    var body: some View {
        HStack(alignment: .center, spacing: Metric.horizontalSpacing) {
            if let leftImage = drawable.leftImage {
                Image(uiImage: leftImage)
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
            
            if let rightImage = drawable.rightImage {
                Image(uiImage: rightImage)
            }
        }
        .padding(Metric.padding)
        .foregroundColor(.set(.lightGray))
        .listRowInsets(EdgeInsets())
    }
}

private extension WidgetLocationView {
    enum Metric {
        static let horizontalSpacing: CGFloat = 10
        static let verticalSpacing: CGFloat = 5
        static let padding: EdgeInsets = .init(top: 10, leading: 20, bottom: 10, trailing: 20)
    }
}

struct WidgetLocationView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WidgetLocationView(drawable: WidgetLocationViewDTO(title: "회사", desc: "판교역"))
                .previewLayout(.fixed(width: 320, height: 50))
        }
    }
}

protocol WidgetLocationViewDrawable {
    var leftImage: UIImage? { get }
    var title: String { get }
    var desc: String? { get }
    var rightImage: UIImage? { get }
}

struct WidgetLocationViewDTO: WidgetLocationViewDrawable {
    var leftImage: UIImage? = .set(.circleMinus)
    let title: String
    let desc: String?
    var rightImage: UIImage? = .set(.menu)
}
