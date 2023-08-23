//
//  EstimateSummarySection.swift
//  iOS_H3_UI
//
//  Created by  sangyeon on 2023/08/20.
//

import Foundation

enum CarMakingCategory: String, CaseIterable {
    case defaultInfo = "car"
    case colorInfo = "color"
    case optionInfo = "additional-option"

    var title: String {
        switch self {
        case .defaultInfo:
            return "팰리세이드 Le Blanc (르블랑)"
        case .colorInfo:
            return "색상"
        case .optionInfo:
            return "옵션"
        }
    }
}
