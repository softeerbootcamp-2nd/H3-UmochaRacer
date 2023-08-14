//
//  NetworkService.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/14.
//

import Foundation
import Combine

protocol NetworkServiceProtocol {
    func request(_ endpoint: Endpoint) -> AnyPublisher<Result<Data, Error>, Never>
    func request<T: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<Result<T, Error>, Never>
}

final class NetworkService: NetworkServiceProtocol {

    private let urlSession: URLSession

    init() {
        urlSession = URLSession.shared
    }

    init(configuration: URLSessionConfiguration) {
        urlSession = URLSession(configuration: configuration)
    }

    /// Endpoint에 데이터를 요청하고 성공시 데이터를 Data 타입으로 반환
    func request(_ endpoint: Endpoint) -> AnyPublisher<Result<Data, Error>, Never> {
        do {
            let urlRequest = try endpoint.toURLRequest()
            return request(to: urlRequest)
        } catch {
            return Just(Result.failure(error)).eraseToAnyPublisher()
        }
    }

    /// Endpoint에 데이터를 요청하고 성공시 데이터를 Generic 타입으로 Decoding 후 반환
    func request<T: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<Result<T, Error>, Never> {
        do {
            let urlRequest = try endpoint.toURLRequest()
            return request(to: urlRequest)
                .map { result in
                    if case .success(let data) = result,
                       let decodedData = try? JSONDecoder().decode(T.self, from: data) {
                        return .success(decodedData)
                    } else if case .failure(let error) = result {
                        return .failure(error)
                    }
                    return .failure(NetworkError.decodeError)
                }
                .eraseToAnyPublisher()
        } catch {
            return Just(Result.failure(error)).eraseToAnyPublisher()
        }
    }

    private func request(to urlRequest: URLRequest) -> AnyPublisher<Result<Data, Error>, Never> {
        urlSession.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response -> Result<Data, Error> in
                guard let httpResponse = response as? HTTPURLResponse,
                      200..<300 ~= httpResponse.statusCode else {
                    return .failure(NetworkError.serverError(response))
                }
                return .success(data)
            }
            .catch { error in
                return Just(Result.failure(NetworkError.clientError(error)))
            }
            .eraseToAnyPublisher()
    }
}
