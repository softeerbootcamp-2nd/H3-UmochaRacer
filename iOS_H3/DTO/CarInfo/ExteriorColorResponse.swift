//
//  ExteriorColorResponse.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/15.
//

import Foundation
struct ExteriorColorResponse: Codable {
    let data: [ExteriorColor]
    let message: String?
    let code: Int?

    struct ExteriorColor: Codable {
        let id: Int?
        let label: String?
        let price: Int?
        let colorCode: String?
        let imageSrc: String?
        let iconSrc: String?
    }
}
