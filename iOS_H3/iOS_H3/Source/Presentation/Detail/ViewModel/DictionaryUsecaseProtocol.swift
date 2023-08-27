//
//  DictionaryUsecaseProtocol.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/23.
//

import Foundation
import Combine

protocol DictionaryUsecaseProtocol {
    func fetchDictionaryDescription(for keyword: String) -> AnyPublisher<String, Error>
}
