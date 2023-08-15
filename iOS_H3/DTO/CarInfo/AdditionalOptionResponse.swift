//
//  AdditionalOptionResponse.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/15.
//

import Foundation

struct AdditionalOptionResponse: Codable {
    let data: [AdditionalOption]
    let message: String?
    let code: Int?

    struct AdditionalOption: Codable {
        let id: Int?
        let name: String?
        let imageSrc: String?
        let price: Int?
        let partsSrc: String?
    }
}
