//
//  DictionaryUsecaseProtocol.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/23.
//

import Combine

protocol DictionaryUsecaseProtocol {
    func fetchDetailedOption() -> Future<String, Error>
}
