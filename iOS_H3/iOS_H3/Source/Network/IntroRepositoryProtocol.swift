//
//  IntroRepositoryProtocol.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/20.
//

import Combine
import Foundation

enum IntroRepositoryError: LocalizedError {
    case networkError(Error)
    case conversionError(EstimateElementToEntityError)

    var errorDescription: String? {
        switch self {
        case .networkError(let error):
            return "[IntroRepositoryError] 네트워크 오류: \(error.localizedDescription)"
        case .conversionError(let error):
            return "[IntroRepositoryError] 변환 오류: \(error.localizedDescription)"
        }
    }
}

protocol IntroRepositoryProtocol {

    func fetchEstimate() -> AnyPublisher<EstimateSummary, Error>
}
