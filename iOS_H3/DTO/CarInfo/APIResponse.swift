//
//  APIResponse.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/18.
//

import Foundation

struct APIResponse<T: Decodable>: Decodable {
    let data: T
    let message: String?
    let code: Int?
}
