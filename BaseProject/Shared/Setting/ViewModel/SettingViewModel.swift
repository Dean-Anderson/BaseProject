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
            return .init(section: .profile, rowItems: [.profile(SettingProfileViewDTO())])
            
        case .car:
            return .init(section: .car, rowItems: [.common(SettingCommonViewDTO(image: ImageAssets.car.uiImage, title: "차량 설정", desc: "99 호 9999"))])
            
        case .guide:
            return .init(section: .guide, rowItems: [.common(SettingCommonViewDTO(image: ImageAssets.roundArrow.uiImage, title: "길안내 설정")),
                                                   .common(SettingCommonViewDTO(image: ImageAssets.chart.uiImage, title: "내비 운행 리포트"))])
            
        case .extra:
            return .init(section: .extra, rowItems: [.common(SettingCommonViewDTO(image: ImageAssets.plus.uiImage, title: "위젯 설정")),
                                                     .common(SettingCommonViewDTO(image: ImageAssets.mic.uiImage, title: "Kakao i 사용설정", postfix: "꺼짐"))])
            
        case .service:
            return .init(section: .service, rowItems: [.common(SettingCommonViewDTO(image: ImageAssets.creditcard.uiImage, title: "결제수단 관리")),
                                                     .common(SettingCommonViewDTO(image: ImageAssets.note.uiImage, title: "서비스 이용기록"))])
            
        case .footer:
            return .init(section: .footer, rowItems: [.footer([SettingFooterItemViewDTO(image: ImageAssets.speaker.uiImage, title: "공지사항"),
                                                               SettingFooterItemViewDTO(image: ImageAssets.star.uiImage, title: "이벤트"),
                                                               SettingFooterItemViewDTO(image: ImageAssets.bubble.uiImage, title: "문의하기"),
                                                               SettingFooterItemViewDTO(image: ImageAssets.note.uiImage, title: "약관/정책")])])
        }
    }
}

enum SettingRow: Identifiable {
    case profile(SettingProfileViewDrawable)
    case common(SettingCommonViewDrawable)
    case footer([SettingFooterItemViewDrawable])
    
    var id: String {
        switch self {
        case let .common(drawable):
            return drawable.title
            
        case let .profile(drawable):
            return drawable.email
            
        case let .footer(drawables):
            return drawables.map { $0.id }.joined()
        }
    }
}

struct SettingSectionItem: Identifiable {
    var id: String { section.rawValue }
    let section: SettingSection
    let rowItems: [SettingRow]
}
