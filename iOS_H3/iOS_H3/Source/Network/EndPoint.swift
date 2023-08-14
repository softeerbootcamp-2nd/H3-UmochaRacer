//
//  EndPoint.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/15.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: [String: String] { get }
    var path: String { get }
    var parameters: HTTPParameter? { get }

    func toURLRequest() throws -> URLRequest
}

enum HTTPMethod: String {
    case GET
    case POST
}

enum HTTPParameter {
    case query([String: String])
    case body(Encodable)
}

extension Endpoint {

    /// Endpoint로부터 URLRequest를 생성
    func toURLRequest() throws -> URLRequest {
        guard let baseURL = URL(string: baseURL) else {
            throw NetworkError.invalidURL(baseURL)
        }
        let url = baseURL.appending(path: path).appending(queries: parameters)
        let urlRequest = URLRequest(url: url)
            .setHttpMethod(httpMethod)
            .appendingHeaders(headers)
            .setBody(for: parameters)
        return urlRequest
    }
}

fileprivate extension URL {

    /// HTTPParameter로부터 URL에 query를 추가
    func appending(queries httpParameter: HTTPParameter?) -> URL {
        var url = self
        if case .query(let quries) = httpParameter {
            let queryItems = quries.map { URLQueryItem(name: $0.key, value: $0.value) }
            url.append(queryItems: queryItems)
        }
        return url
    }
}

fileprivate extension URLRequest {

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
