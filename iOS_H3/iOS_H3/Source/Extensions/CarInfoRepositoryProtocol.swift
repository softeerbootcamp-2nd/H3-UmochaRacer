//
//  CarInfoRepositoryProtocol.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/15.
//

import Foundation
import Combine

enum CarInfoRepositoryError: LocalizedError {
    case networkError(Error)
    case conversionError(CarOptionToEntityError)

    var errorDescription: String? {
        switch self {
        case .networkError(let error):
            return "네트워크 오류: \(error.localizedDescription)"
        case .conversionError(let error):
            return "변환 오류: \(error.localizedDescription)"
        }
    }
}


protocol CarInfoRepositoryProtocol {
    typealias APIResult<T> = AnyPublisher<Result<T, Error>, Never>
    func fetchPowertrain(model: String, type: String) -> AnyPublisher<CarMakingStepInfo, CarInfoRepositoryError>

    func fetchDrivingSystem() -> AnyPublisher<CarMakingStepInfo, CarInfoRepositoryError>

    func fetchBodyType() -> AnyPublisher<CarMakingStepInfo, CarInfoRepositoryError>

    func fetchExteriorColor() -> AnyPublisher<CarMakingStepInfo, CarInfoRepositoryError>

    func fetchInteriorColor() -> AnyPublisher<CarMakingStepInfo, CarInfoRepositoryError>

    func fetchWheel() -> AnyPublisher<CarMakingStepInfo, CarInfoRepositoryError>

    func fetchAdditionalOption(category: String) -> AnyPublisher<CarMakingStepInfo, CarInfoRepositoryError>

    func fetchSingleExteriorColor(optionId: Int) -> AnyPublisher<CarMakingStepInfo, CarInfoRepositoryError>
    // TODO: Intro Repository 분리
    func fetchEstimate() -> AnyPublisher<EstimateSummary, Never>
}
