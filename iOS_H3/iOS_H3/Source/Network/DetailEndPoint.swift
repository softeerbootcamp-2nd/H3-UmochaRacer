//
//  DetailEndPoint.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/23.
//

import Foundation

enum DetailEndPoint: Endpoint {
    case powertrain(id: Int)
    case drivingSystem(id: Int)
    case bodyType(id: Int)
    case wheel(id: Int)
    case additionalOption(id: Int)

    var baseURL: String { ConstantKey.baseURL }
    var httpMethod: HTTPMethod { .GET }
    var headers: [String: String] { [:] }

    var path: String {
        switch self {
        case .powertrain:
            return "/detail/powertrain"
        case .drivingSystem:
            return "info/driving-system"
        case .bodyType:
            return "info/bodytype"
        case .wheel:
            return "info/wheel"
        case .additionalOption:
            return "info/additional-option"
        }
    }

    var parameters: HTTPParameter? {
        switch self {

        case .powertrain(let id):
            return .query(["id": "\(id)"])
        case .drivingSystem(let id):
            return .query(["id": "\(id)"])
        case .bodyType(let id):
            return .query(["id": "\(id)"])
        case .wheel(let id):
            return .query(["id": "\(id)"])
        case .additionalOption(let id):
            return .query(["id": "\(id)"])
        }
    }
}
