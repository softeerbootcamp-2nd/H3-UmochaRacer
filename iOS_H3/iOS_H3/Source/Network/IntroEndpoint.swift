//
//  IntroEndpoint.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/20.
//

import Foundation
enum IntroEndpoint: Endpoint {
    case interiorColor
    case exteriorColor
    case estimate
    case additionalOption(trimId: Int, category: String, page: Int, size: Int)

    var baseURL: String { ConstantKey.baseURL }
    var httpMethod: HTTPMethod { .GET }
    var headers: [String: String] { [:] }

    var path: String {
        switch self {
        case .interiorColor:
            return "intro/interior-color"
        case .exteriorColor:
            return "intro/exterior-color"
        case .estimate:
            return "intro/estimate"
        case .additionalOption:
            return "intro/additional-option"
        }
    }

    var parameters: HTTPParameter? {
        switch self {

        case .additionalOption(let trimId, let category, let page, let size):
            return .query(["trimId": "\(trimId)",
                           "category": category,
                           "page": "\(page)",
                           "size": "\(size)"])
        default:
            return nil
        }
    }
}
