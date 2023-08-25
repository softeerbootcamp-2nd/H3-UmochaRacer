//
//  URString.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/21.
//

import Foundation

struct URString: Hashable {
    let fullText: String
    let cardbRange: [Range<Int>]

    init(fullText: String, cardbRange: [Range<Int>] = []) {
        self.fullText = fullText
        self.cardbRange = cardbRange
    }
}
