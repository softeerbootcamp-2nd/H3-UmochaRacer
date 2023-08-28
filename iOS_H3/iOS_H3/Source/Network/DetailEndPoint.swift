//
//  DetailEndPoint.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/28.
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
        case .powertrain(let id):
            return "detail/powertrain/\(id)"
        case .drivingSystem(let id):
            return "detail/driving-system/\(id)"
        case .bodyType(let id):
            return "detail/bodytype/\(id)"
        case .wheel(let id):
            return "detail/wheel/\(id)"
        case .additionalOption(let id):
            return "detail/additional-option/\(id)"
        }
    }

    var parameters: HTTPParameter? {
       return nil
    }
}
