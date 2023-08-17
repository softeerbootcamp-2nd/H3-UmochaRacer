//
//  CarInfoRepository.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/15.
//

import Foundation
import Combine

final class CarInfoRepository: CarInfoRepositoryProtocol {
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    private func fetchCarMakingStepInfo(for endpoint: Endpoint,
                                        step: CarMakingStep) -> AnyPublisher<CarMakingStepInfo, Never> {
        networkService.request(endpoint)
            .map { (result: Result<APIResponse<[CarOptionData]>, Error>) -> CarMakingStepInfo in
                switch result {
                case .success(let data):
                    let array = data.data.map { $0.toDomain() }
                    return CarMakingStepInfo(step: step, optionCardInfoArray: array)
                case .failure(let error):
                    return CarMakingStepInfo(step: step)
                }
            }
            .eraseToAnyPublisher()
    }

    func fetchPowertrain(model: String, type: String) -> AnyPublisher<CarMakingStepInfo, Never> {
        fetchCarMakingStepInfo(for: CarInfoEndpoint.powertrain(model: model, type: type), step: .powertrain)
    }

    func fetchDrivingSystem() -> AnyPublisher<CarMakingStepInfo, Never> {
        fetchCarMakingStepInfo(for: CarInfoEndpoint.drivingSystem, step: .driveMethod)
    }

    func fetchBodyType() -> AnyPublisher<CarMakingStepInfo, Never> {
        fetchCarMakingStepInfo(for: CarInfoEndpoint.bodyType, step: .bodyType)
    }

    func fetchExteriorColor() -> AnyPublisher<CarMakingStepInfo, Never> {
        fetchCarMakingStepInfo(for: CarInfoEndpoint.exteriorColor, step: .externalColor)
    }

    func fetchInteriorColor() -> AnyPublisher<CarMakingStepInfo, Never> {
        fetchCarMakingStepInfo(for: CarInfoEndpoint.interiorColor, step: .internalColor)
    }

    func fetchWheel() -> AnyPublisher<CarMakingStepInfo, Never> {
        fetchCarMakingStepInfo(for: CarInfoEndpoint.wheel, step: .wheelSelection)
    }

    func fetchAdditionalOption(category: String) -> AnyPublisher<CarMakingStepInfo, Never> {
        fetchCarMakingStepInfo(for: CarInfoEndpoint.wheel, step: .optionSelection)
    }

    func fetchSingleExteriorColor(optionId: Int) -> AnyPublisher<CarMakingStepInfo, Never> {
        fetchCarMakingStepInfo(for: CarInfoEndpoint.wheel, step: .externalColor)
    }

    // TODO: IntroRepository로 분리
    func fetchEstimate() -> AnyPublisher<EstimateSummary, Never> {
        networkService.request(CarInfoEndpoint.estimate)
            .map { (result: Result<APIResponse<[EstimateElementData]>, Error>) -> EstimateSummary in
                switch result {
                case .success(let data):
                    let array = data.data.map { $0.toDomain() }
                    return EstimateSummary(elements: array)
                case .failure(let error):
                    return EstimateSummary(elements: [])
                }
            }
            .eraseToAnyPublisher()
    }
}
