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
    // TODO: Intro Endpoint분리
    case estimate

    var baseURL: String { ConstantKey.baseURL }
    var httpMethod: HTTPMethod { .GET }
    var headers: [String: String] { [:] }

    var path: String {
        switch self {
        case .powertrain:
            return "info/powertrain"
        case .drivingSystem:
            return "info/driving-system"
        case .bodyType:
            return "info/bodytype"
        case .exteriorColor:
            return "info/exterior-color"
        case .interiorColor:
            return "info/interior-color"
        case .wheel:
            return "info/wheel"
        case .additionalOption:
            return "info/additional-option"
        case .singleExteriorColor(let optionId):
            return "info/exterior-color/\(optionId)"
        case .estimate:
            return "intro/estimate"
        }
    }

    var parameters: HTTPParameter? {
        switch self {
        case .powertrain(let model, let type):
            return .query(["model": model, "type": type])
        case .additionalOption(let category):
            return .query(["category": category])
        case .interiorColor:
            return .query(["exteriorColorId": "6"])
        default:
            return nil
        }
    }
}
