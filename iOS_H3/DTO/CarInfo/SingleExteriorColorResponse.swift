//
//  SingleExteriorColorResponse.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/15.
//

import Foundation

struct SingleExteriorColorResponse: Codable {
    let data: [SingleExteriorColor]
    let message: String?
    let code: Int?

    struct SingleExteriorColor: Codable {
        let id: Int?
        let name: String?
        let imageSrc: String?
        let price: Int?
        let colorCode: String?
        let iconSrc: String?
    }
}
