//
//  DetailOptionData.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/23.
//

import Foundation

struct DetailOptionData: Decodable {
    let title: String?
    let description: String?
    let info: String?
    let imageSrc: Int?
}

struct DetailOptionEntity {
    let title: String
    let description: String
    let info: String?
    let imageSrc: Int?
}
