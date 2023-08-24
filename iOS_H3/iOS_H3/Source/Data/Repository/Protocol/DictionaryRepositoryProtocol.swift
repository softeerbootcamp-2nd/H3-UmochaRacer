//
//  DictionaryRepositoryProtocol.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/24.
//

import Foundation
import Combine

protocol DictionaryRepositoryProtocol {
    func fetchDictionaryDescription(for keyword: String) -> AnyPublisher<URDictionaryEntity, Error>
}
