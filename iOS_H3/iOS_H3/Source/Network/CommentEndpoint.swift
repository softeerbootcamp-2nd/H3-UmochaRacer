//
//  CommentEndpoint.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/23.
//

import Foundation

enum CommentEndpoint: Endpoint {
    case powertrain(id: Int)
    case drivingSystem(id: Int)
    case bodyType(id: Int)
    case exteriorColor(id: Int)
    case interiorColor(id: Int)
    case wheel(id: Int)

    var baseURL: String { ConstantKey.baseURL }
    var httpMethod: HTTPMethod { .GET }
    var headers: [String: String] { [:] }

    var path: String {
        switch self {
        case .powertrain(let id):
            return "comment/powertrain/\(id)"
        case .drivingSystem(let id):
            return "comment/driving-system/\(id)"
        case .bodyType(let id):
            return "comment/bodytype/\(id)"
        case .exteriorColor(let id):
            return "comment/exterior-color/\(id)"
        case .interiorColor(let id):
            return "comment/interior-color/\(id)"
        case .wheel(let id):
            return "comment/wheel/\(id)"
        }
    }

    var parameters: HTTPParameter? { nil }
}
