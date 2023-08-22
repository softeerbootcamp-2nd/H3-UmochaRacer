//
//  SelfModeUsecaseProtocol.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/16.
//

import Foundation
import Combine

enum SelfModeUsecaseError: LocalizedError {
    case networkError(error: Error)
    case conversionError(error: Error)
    case invalidStep

    var errorDescription: String? {
        switch self {
        case .networkError(let error):
            return "[SelfModeUsecaseError] \(error.localizedDescription)"
        case .conversionError(let error):
            return "[SelfModeUsecaseError] \(error.localizedDescription)"
        case .invalidStep:
            return "[SelfModeUsecaseError] 유효하지 않은 내차만들기 단계입니다."
        }
    }
}

protocol SelfModeUsecaseProtocol {
    func fetchInitialEstimate() -> AnyPublisher<EstimateSummary, SelfModeUsecaseError>

    func fetchOptionInfo(step: CarMakingStep) -> AnyPublisher<CarMakingStepInfo, SelfModeUsecaseError>

    func updateEstimateSummary(
        step: CarMakingStep,
        selectedOption: OptionCardInfo
    ) -> AnyPublisher<EstimateSummary, Never>

    func fetchAdditionalOptionInfo(
        category: OptionCategoryType
    ) -> AnyPublisher<CarMakingStepInfo, SelfModeUsecaseError>
}
