//
//  EstimateSummary.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/16.
//

import Foundation

struct EstimateSummary {
    let elements: [EstimateSummaryElement]
}

struct EstimateSummaryElement {
    let stepName: String
    let selectedOption: String
    let category: String
    let price: Int
}
