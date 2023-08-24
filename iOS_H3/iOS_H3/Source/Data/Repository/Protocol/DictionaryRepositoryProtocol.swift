//
//  DictionaryRepositoryProtocol.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/24.
//

import Foundation
import Combine

enum DictionaryRepositoryError: LocalizedError {
    case networkError(Error)
    case conversionError(Error)

    var errorDescription: String? {
        switch self {
        case .networkError(let error):
            return "[DictionaryRepository] 네트워크 오류: \(error.localizedDescription)"
        case .conversionError(let error):
            return "[DictionaryRepository] 변환 오류: \(error.localizedDescription)"
        }
    }
}

protocol DictionaryRepositoryProtocol {
    func fetchDictionaryDescription(for keyword: String) -> AnyPublisher<URDictionaryEntity, Error>
}
