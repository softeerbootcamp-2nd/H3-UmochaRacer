//
//  EstimateElementData.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/18.
//

import Foundation

enum EstimateElementToEntityError: LocalizedError {
    case missingCategory
    case missingKey
    case missingValue
    case negativePrice
    case invalidCategory

    var errorDescription: String? {
        switch self {
        case .missingCategory:
            return "카테고리 값이 없습니다."
        case .missingKey:
            return "키 값이 없습니다."
        case .missingValue:
            return "타입 값이 없습니다."
        case .negativePrice:
            return "가격 값이 음수일 수 없습니다."
        case .invalidCategory:
            return "유효하지 않은 카테고리입니다."
        }
    }
}

struct EstimateElementData: Decodable {
    let category: String?
    let key: String?
    let value: String?
    let price: Int?
}

extension EstimateElementData {
    func toDomain() throws -> EstimateSummaryElement {
        guard let category = self.category else {
            throw EstimateElementToEntityError.missingCategory
        }
        guard let key = self.key else {
            throw EstimateElementToEntityError.missingKey
        }
        guard let value = self.value else {
            throw EstimateElementToEntityError.missingValue
        }
        guard let price = self.price, price >= 0 else {
            throw EstimateElementToEntityError.negativePrice
        }

        #warning("서버 응답에 따른 임시 코드입니다. 서버 수정 되면 주석 코드로 수정 필요")
        guard let carMakingCategory = CarMakingCategory(rawValue: value) else {
            throw EstimateElementToEntityError.invalidCategory
        }
        return EstimateSummaryElement(stepName: category,
                                      selectedOption: key,
                                      category: carMakingCategory,
                                      price: price)
//        guard let carMakingCategory = CarMakingCategory(rawValue: category) else {
//            throw EstimateElementToEntityError.invalidCategory
//        }
//        return EstimateSummaryElement(stepName: key,
//                                      selectedOption: value,
//                                      category: carMakingCategory,
//                                      price: price)
    }
}
