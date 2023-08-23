//
//  TrimCategory.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/23.
//

import Foundation

enum TrimCategory {
    case guideMode
    case leBlanc
    case exclusive
    case prestige
    case calligraphy

    var title: String {
        switch self {
        case .guideMode:
            return "Guide Mode"
        case .leBlanc:
            return "Le Blanc"
        case .exclusive:
            return "Exclusive"
        case .prestige:
            return "Prestige"
        case .calligraphy:
            return "Calligraphy"
        }
    }

    var hashTag: String {
        switch self {
        case .guideMode:
            return "#나만을 위한 팰리세이드"
        case .leBlanc:
            return "#베스트셀러"
        case .exclusive:
            return "#기본에 충실"
        case .prestige:
            return "#부담없는 고급감"
        case .calligraphy:
            return "#최고를 원한다면"
        }
    }
}
