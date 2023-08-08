//
//  CarMakingStep.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/06.
//

import Foundation

enum CarMakingStep: Int, CaseIterable {
    case powertrain = 1
    case driveMethod
    case bodyType
    case externalColor
    case internalColor
    case wheelSelection
    case optionSelection
    case makingEstimate

    var title: String {
        switch self {
        case .powertrain:
            return "파워트레인"
        case .driveMethod:
            return "구동 방식"
        case .bodyType:
            return "바디 타입"
        case .externalColor:
            return "외장 색상"
        case .internalColor:
            return "내장 색상"
        case .wheelSelection:
            return "휠"
        case .optionSelection:
            return "옵션"
        case .makingEstimate:
            return "견적 내기"
        }
    }

    var progressBarTitle: String {
        var title = (self.rawValue < 10 ? "0" : "") + "\(self.rawValue) "
        switch self {
        case .wheelSelection:
            title += "휠 선택"
        case .optionSelection:
            title += "옵션 선택"
        default:
            title += self.title
        }
        return title
    }
}
