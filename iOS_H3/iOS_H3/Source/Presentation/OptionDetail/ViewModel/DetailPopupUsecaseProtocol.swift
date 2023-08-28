//
//  DetailPopupUsecaseProtocol.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/21.
//

import Combine
import Foundation

enum DetailUsecaseError: LocalizedError {
    case networkError(error: Error)
    case conversionError(error: Error)
    case invalidStep
    case notExistSelf

    var errorDescription: String? {
        switch self {
        case .networkError(let error):
            return "[DetailUsecaseError] \(error.localizedDescription)"
        case .conversionError(let error):
            return "[DetailUsecaseError] \(error.localizedDescription)"
        case .invalidStep:
            return "[DetailUsecaseError] 유효하지 않은 내차만들기 단계입니다."
        case .notExistSelf:
            return "[DetailUsecaseError] notExistSelf Error"
        }
    }
}

protocol DetailPopupUsecaseProtocol {
    func fetchAllDetails(step: CarMakingStep, id: Int)
    -> AnyPublisher<DetailOptionInfo, DetailUsecaseError>
    func fetchAllAdditionalOptions(id: Int)
    -> AnyPublisher<[DetailOptionInfo], DetailUsecaseError>
}
