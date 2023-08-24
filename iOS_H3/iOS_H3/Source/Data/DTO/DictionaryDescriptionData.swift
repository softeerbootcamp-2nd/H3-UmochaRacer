//
//  DictionaryData.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/24.
//

import Foundation

enum DictionaryDescriptionDataToEntityError: LocalizedError {
    case missingKeyword
    case missingDescription

    var errorDescription: String? {
        switch self {
        case .missingKeyword:
            return "키워드가 존재하지 않습니다."
        case .missingDescription:
            return "키워드에 대한 설명이 존재하지 않습니다."
        }
    }
}

struct DictionaryDescriptionData: Decodable {
    let keyword: String?
    let description: String?
    let imageSrc: String?

    func toDomain() throws -> DictionaryDescription {
        guard let keyword else {
            throw DictionaryDescriptionDataToEntityError.missingKeyword
        }
        guard let description else {
            throw DictionaryDescriptionDataToEntityError.missingDescription
        }
        return DictionaryDescription(keyword: keyword, description: description, imageURL: URL(string: imageSrc ?? ""))
    }
}
