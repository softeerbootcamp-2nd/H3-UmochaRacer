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

        let url = baseURL.appendingPath(path).appendingQueries(parameters)
        var urlRequest = URLRequest(url: url)
        urlRequest.setHttpMethod(httpMethod)
        urlRequest.appendingHeaders(headers)
        urlRequest.setBody(for: parameters)

        return urlRequest
    }
}
