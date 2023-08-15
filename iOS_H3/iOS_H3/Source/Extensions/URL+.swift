//
//  URL+.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/15.
//

import Foundation

extension URL {

    func appendingPath(_ path: String) -> URL {
        var url = self
        if #available(iOS 16.0, *) {
            url.append(path: path)
        } else {
            url.appendPathComponent(path)
        }
        return url
    }

    /// HTTPParameter로부터 URL에 query를 추가
    func appendingQueries(_ httpParameter: HTTPParameter?) -> URL {
        var url = self
        if case .query(let quries) = httpParameter {
            if #available(iOS 16.0, *) {
                let queryItems = quries.map { URLQueryItem(name: $0.key, value: $0.value) }
                url.append(queryItems: queryItems)
            } else {
                let queryString = quries.map { "?\($0.key)=\($0.value)" }.joined()
                url = url.appendingPath(queryString)
            }
        }
        return url
    }
}
