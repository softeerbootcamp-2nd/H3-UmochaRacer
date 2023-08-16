//
//  CarInfoEndpoint.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/15.
//

import Foundation

enum CarInfoEndpoint: Endpoint {
    case powertrain(model: String, type: String)
    case drivingSystem
    case bodyType
    case exteriorColor
    case interiorColor
    case wheel
    case additionalOption(category: String)
    case singleExteriorColor(optionId: Int)

    var baseURL: String { ConstantKey.baseURL }
    var httpMethod: HTTPMethod { .GET }
    var headers: [String: String] { [:] }

    var path: String {
        switch self {
        case .powertrain:
            return "/powertrain"
        case .drivingSystem:
            return "/driving-system"
        case .bodyType:
            return "/bodytype"
        case .exteriorColor:
            return "/exterior-color"
        case .interiorColor:
            return "/interior-color"
        case .wheel:
            return "/wheel"
        case .additionalOption:
            return "/additional-option"
        case .singleExteriorColor(let optionId):
            return "/exterior-color/\(optionId)"
        }
    }

    var parameters: HTTPParameter? {
        switch self {
        case .powertrain(let model, let type):
            return .query(["model": model, "type": type])
        case .additionalOption(let category):
            return .query(["category": category])
        default:
            return nil
        }
    }
}
