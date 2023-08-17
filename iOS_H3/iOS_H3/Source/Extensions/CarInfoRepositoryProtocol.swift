//
//  CarInfoRepositoryProtocol.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/15.
//

import Foundation
import Combine

protocol CarInfoRepositoryProtocol {
    typealias APIResult<T> = AnyPublisher<Result<T, Error>, Never>
    func fetchPowertrain(model: String, type: String) -> AnyPublisher<CarMakingStepInfo, Never>

    func fetchDrivingSystem() -> AnyPublisher<CarMakingStepInfo, Never>

    func fetchBodyType() -> AnyPublisher<CarMakingStepInfo, Never>

    func fetchExteriorColor() -> AnyPublisher<CarMakingStepInfo, Never>

    func fetchInteriorColor() -> AnyPublisher<CarMakingStepInfo, Never>

    func fetchWheel() -> AnyPublisher<CarMakingStepInfo, Never>

    func fetchAdditionalOption(category: String) -> AnyPublisher<CarMakingStepInfo, Never>

    func fetchSingleExteriorColor(optionId: Int) -> AnyPublisher<CarMakingStepInfo, Never>
    // TODO: Intro Repository 분리
    func fetchEstimate() -> AnyPublisher<EstimateSummary, Never>
}
