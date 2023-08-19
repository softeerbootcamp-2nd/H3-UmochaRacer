//
//  EstimateElementData.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/18.
//

import Foundation

struct EstimateElementData: Decodable {
    let category: String?
    let key: String?
    let value: String?
    let price: Int?
}

extension EstimateElementData {
    func toDomain() -> EstimateSummaryElement {
        return EstimateSummaryElement(stepName: self.key ?? "",
                                      selectedOption: self.value ?? "",
                                      category: self.category ?? "",
                                      price: self.price ?? 0)
    }
}
