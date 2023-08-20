//
//  SelfModeUsecaseProtocol.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/16.
//

import Combine

enum SelfModeUsecaseError: Error {
    case networkError
    case conversionError
    case invalidStep
}

protocol SelfModeUsecaseProtocol {
    func fetchInitialEstimate() -> AnyPublisher<EstimateSummary, Never>

    func fetchOptionInfo(step: CarMakingStep) -> AnyPublisher<CarMakingStepInfo, SelfModeUsecaseError>

    func updateEstimateSummary(step: CarMakingStep,
                               selectedOption: OptionCardInfo) -> AnyPublisher<EstimateSummary, Never>
}
