//
//  DetailOptionData.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/28.
//

import Foundation

enum DetailOptionToEntityError: LocalizedError {
    case missingTitle
    case missingDescription

    var errorDescription: String? {
        switch self {
        case .missingTitle:
            return "제목 값이 없습니다."
        case .missingDescription:
            return "설명 값이 없습니다."
        }
    }
}

struct DetailOptionData: Decodable {
    let title: String?
    let description: String?
    let info: String?
    let imageSrc: String?
}

extension DetailOptionData {
    func toDomain() throws -> DetailOptionEntity {

        guard let title = self.title else {
            throw DetailOptionToEntityError.missingTitle
        }

        guard let description = self.description else {
            throw DetailOptionToEntityError.missingDescription
        }

        return DetailOptionEntity(
            title: title,
            description: description,
            info: self.info,
            imageSrc: self.imageSrc
        )
    }
}
