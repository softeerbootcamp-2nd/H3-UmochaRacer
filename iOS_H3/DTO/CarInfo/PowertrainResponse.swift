//
//  PowertrainResponse.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/15.
//

import Foundation

struct PowertrainResponse: Decodable {
    let data: [Powertrain]
    let message: String?
    let code: Int?

    struct Powertrain: Decodable {
        let id: Int?
        let name: String?
        let price: Int?
        let imageSrc: String?
    }
}
