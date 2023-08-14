//
//  NetworkError.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/15.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL(_ baseURL: String)
    case serverError(_ response: URLResponse)
    case clientError(_ error: Error)
    case decodeError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL(let baseURL):
            return "InvalideURL Error: baseURL(\(baseURL))이 유효하지 않습니다"
        case .serverError(let response):
            return "Server Error: \(response)"
        case .clientError(let error):
            return "Client Error: \(error)"
        case .decodeError:
            return "Decode Error: 데이터 Decoding에 실패했습니다."
        }
    }
}
