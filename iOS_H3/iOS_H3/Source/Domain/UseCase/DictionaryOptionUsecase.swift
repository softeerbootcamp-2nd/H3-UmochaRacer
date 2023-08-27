//
//  DictionaryOptionUsecase.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/23.
//

import Combine

class DictionaryOptionUsecase: DictionaryUsecaseProtocol {
    func fetchDictionaryDescription(for keyword: String) -> AnyPublisher<String, Error> {
        Just("설명이 오는 텍스트입니다.").setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}
