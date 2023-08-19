//
//  SelfModeUsecaseProtocol.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/16.
//

import Combine
import Foundation

protocol SelfModeUsecaseProtocol {
    func fetchInitialEstimate() -> AnyPublisher<EstimateSummary, Never>

    func fetchOptionInfo(step: CarMakingStep) -> AnyPublisher<CarMakingStepInfo, Never>

    func updateEstimateSummary(step: CarMakingStep,
                               selectedOption: OptionCardInfo) -> AnyPublisher<EstimateSummary, Never>
}
