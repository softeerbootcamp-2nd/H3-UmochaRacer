//
//  DictionaryOptionUsecase.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/23.
//

import Combine

class DictionaryOptionUsecase: DictionaryUsecaseProtocol {
    func fetchDetailedOption() -> Future<String, Error> {
        Future { promise in
            promise(.success(String("설명이 오는 텍스트입니다.")))
                
        }
    }
}
