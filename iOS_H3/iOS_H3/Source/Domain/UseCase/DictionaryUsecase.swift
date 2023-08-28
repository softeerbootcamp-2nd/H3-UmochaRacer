//
//  DictionaryUsecase.swift
//  iOS_H3
//
//  Created by sangyeon  on 2023/08/23.
//

import Foundation
import Combine

final class DictionaryUsecase: DictionaryUsecaseProtocol {

    private let dictionaryRepository: DictionaryRepositoryProtocol

    init(dictionaryRepository: DictionaryRepositoryProtocol) {
        self.dictionaryRepository = dictionaryRepository
    }

    func fetchDictionaryDescription(for keyword: String) -> AnyPublisher<String, Error> {
        dictionaryRepository.fetchDictionaryDescription(for: keyword)
            .map { entity in
                return entity.description
            }
            .eraseToAnyPublisher()
    }
}
