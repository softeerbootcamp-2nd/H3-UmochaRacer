//
//  DictionaryEndpoint.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/24.
//

import Foundation

enum DictionaryEndpoint: Endpoint {
    case cardb(keyword: String)

    var baseURL: String { ConstantKey.baseURL }
    var httpMethod: HTTPMethod { .GET }
    var headers: [String : String] { [:] }
    
    var path: String { "cardb" }
    
    var parameters: HTTPParameter? {
        switch self {
        case .cardb(let keyword):
            return .query(["keyword": keyword])
        }
    }
}
