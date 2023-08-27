//
//  DictionaryRepository.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/24.
//

import Foundation
import Combine

final class DictionaryRepository: DictionaryRepositoryProtocol {

    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func fetchDictionaryDescription(for keyword: String) -> AnyPublisher<DictionaryDescription, Error> {
        typealias ResultType = Result<APIResponse<DictionaryDescriptionData>, Error>
        typealias ReturnType = AnyPublisher<DictionaryDescription, Error>

        let endpoint = DictionaryEndpoint.cardb(keyword: keyword)
        return networkService.request(endpoint)
            .flatMap { (result: ResultType) -> ReturnType in
                switch result {
                case .success(let response):
                    do {
                        let entity = try response.data.toDomain()
                        return Just(entity).setFailureType(to: Error.self).eraseToAnyPublisher()
                    } catch {
                        return Fail(error: DictionaryRepositoryError.conversionError(error)).eraseToAnyPublisher()
                    }
                case .failure(let error):
                    return Fail(error: DictionaryRepositoryError.networkError(error)).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}
