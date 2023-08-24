//
//  URLRequest+.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/15.
//

import Foundation

extension URLRequest {

    /// URLRequest의 httpMethod를 설정
    mutating func setHttpMethod(_ httpMethod: HTTPMethod) {
        self.httpMethod = httpMethod.rawValue
    }

    /// URLRequest의 header field 설정
    mutating func appendingHeaders(_ headers: [String: String]) {
        headers.forEach { header in
            addValue(header.value, forHTTPHeaderField: header.key)
        }
    }

    /// HTTPParameter로부터 URLRequest의 body를 설정
    mutating func setBody(for httpParameter: HTTPParameter?) {
        if case .body(let data) = httpParameter {
            httpBody = try? JSONEncoder().encode(data)
        }
    }
}
