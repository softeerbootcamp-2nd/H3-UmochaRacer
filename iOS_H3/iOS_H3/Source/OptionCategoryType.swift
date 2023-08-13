//
//  CategoryStep.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/13.
//

import Foundation
enum OptionCategoryType: Int, CaseIterable {
    case system = 1
    case temperatureManagement
    case externalDevice
    case InternalDevice
    

    var title: String {
        switch self {
        case .system:
            return "시스템"
        case .temperatureManagement:
            return "온도관리"
        case .externalDevice:
            return "외부장치"
        case .InternalDevice:
            return "내부장치"
        }
    }
}
