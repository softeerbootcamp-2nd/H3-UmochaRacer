//
//  URLRequest+.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/15.
//

import Foundation

extension URLRequest {

    /// URLRequest의 httpMethod를 설정
    func setHttpMethod(_ httpMethod: HTTPMethod) -> URLRequest {
        var urlRequest = self
        urlRequest.httpMethod = httpMethod.rawValue
        return urlRequest
    }

    /// URLRequest의 header field 설정
    func appendingHeaders(_ headers: [String: String]) -> URLRequest {
        var urlRequest = self
        headers.forEach { header in
            urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
        }
        return urlRequest
    }

    /// HTTPParameter로부터 URLRequest의 body를 설정
    func setBody(for httpParameter: HTTPParameter?) -> URLRequest {
        var urlRequest = self
        if case .body(let data) = httpParameter {
            urlRequest.httpBody = try? JSONEncoder().encode(data)
        }
        return urlRequest
    }
}
