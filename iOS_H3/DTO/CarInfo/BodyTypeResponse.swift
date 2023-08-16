//
//  BodyTypeResponse.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/15.
//

import Foundation

struct BodyTypeResponse: Codable {
    let data: [BodyType]
    let message: String?
    let code: Int?

    struct BodyType: Codable {
        let id: Int?
        let label: String?
        let price: Int?
        let iconSrc: String?
        let imageSrc: String?
    }
}
