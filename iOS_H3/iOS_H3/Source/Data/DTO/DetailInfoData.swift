//
//  DetailInfoData.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/28.
//

import Foundation

struct DetailInfoData: Decodable {
    let title: String?
    let description: String?
    let info: String?
    let imageSrc: String?
}

extension DetailInfoData {
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
