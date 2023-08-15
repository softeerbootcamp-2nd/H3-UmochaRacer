//
//  URL+.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/15.
//

import Foundation

extension URL {

    mutating func appendingPath(_ path: String) {
        if #available(iOS 16.0, *) {
            append(path: path)
        } else {
            appendPathComponent(path)
        }
    }

    /// HTTPParameter로부터 URL에 query를 추가
    mutating func appendingQueries(_ httpParameter: HTTPParameter?) {
        if case .query(let quries) = httpParameter {
            if #available(iOS 16.0, *) {
                let queryItems = quries.map { URLQueryItem(name: $0.key, value: $0.value) }
                append(queryItems: queryItems)
            } else {
                let queryString = quries.map { "?\($0.key)=\($0.value)" }.joined()
                appendingPath(queryString)
            }
        }
    }
}
