//
//  DrivingSystemResponse.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/15.
//

import Foundation

struct DrivingSystemResponse: Codable {
    let data: [DrivingSystem]
    let message: String?
    let code: Int?

    struct DrivingSystem: Codable {
        let id: Int?
        let name: String?
        let imageSrc: String?
        let price: Int?
    }
}
