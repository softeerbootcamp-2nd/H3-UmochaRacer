//
//  WheelResponse.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/15.
//

import Foundation

struct WheelResponse: Codable {
    let data: [Wheel]
    let message: String?
    let code: Int?

    struct Wheel: Codable {
        let id: Int?
        let label: String?
        let price: Int?
        let imageSrc: String?
        let parts: String?
        let partsSrc: String?
    }
}
