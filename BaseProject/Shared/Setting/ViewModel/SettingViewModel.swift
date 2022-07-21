//
//  SettingViewModel.swift
//  BaseProject (iOS)
//
//  Created by dean.anderson on 2022/07/21.
//

import Foundation

final class SettingViewModel: ObservableObject {
    @Published var dataSource: [SettingSectionItem] = SettingSection.allCases.map { $0.create() }
}

enum SettingSection: String, CaseIterable {
    case profile
    case car
    case guide
    case extra
    case service
    case footer
}

extension SettingSection {
    func create() -> SettingSectionItem {
        switch self {
        case .profile:
            return .init(section: .profile, rowItems: [])
            
        case .car:
            return .init(section: .car, rowItems: [])
            
        case .guide:
            return .init(section: .guide, rowItems: [.common(SettingCommonViewDTO(image: ImageAssets.ic_24_tab_home_on.uiImage, title: "길안내 설정")),
                                                   .common(SettingCommonViewDTO(image: ImageAssets.ic_24_tab_home_on.uiImage, title: "내비 운행 리포트"))])
            
        case .extra:
            return .init(section: .extra, rowItems: [.common(SettingCommonViewDTO(image: ImageAssets.ic_24_tab_home_on.uiImage, title: "위젯 설정")),
                                                     .common(SettingCommonViewDTO(image: ImageAssets.ic_24_tab_home_on.uiImage, title: "Kakao i 사용설정", postfix: "꺼짐"))])
            
        case .service:
            return .init(section: .service, rowItems: [.common(SettingCommonViewDTO(image: ImageAssets.ic_24_tab_home_on.uiImage, title: "결제수단 관리")),
                                                     .common(SettingCommonViewDTO(image: ImageAssets.ic_24_tab_home_on.uiImage, title: "서비스 이용기록"))])
            
        case .footer:
            return .init(section: .footer, rowItems: [])
        }
    }
}

enum SettingRow: Identifiable {
    case common(SettingCommonViewDrawable)
    
    var id: String {
        switch self {
        case let .common(drawable):
            return drawable.title
        }
    }
}

struct SettingSectionItem: Identifiable {
    var id: String { section.rawValue }
    let section: SettingSection
    let rowItems: [SettingRow]
}
