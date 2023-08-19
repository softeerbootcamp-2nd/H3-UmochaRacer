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
                                        step: CarMakingStep) -> AnyPublisher<CarMakingStepInfo, CarInfoRepositoryError> {
        networkService.request(endpoint)
            .flatMap { (result: Result<APIResponse<[CarOptionData]>, Error>) -> AnyPublisher<CarMakingStepInfo, CarInfoRepositoryError> in
                switch result {
                case .success(let data):
                    do {
                        let array = try data.data.map { try $0.toDomain() }
                        return Just(CarMakingStepInfo(step: step, optionCardInfoArray: array))
                            .setFailureType(to: CarInfoRepositoryError.self)
                            .eraseToAnyPublisher()
                    } catch let error as CarOptionToEntityError {
                        return Fail(outputType: CarMakingStepInfo.self, failure: CarInfoRepositoryError.conversionError(error))
                            .eraseToAnyPublisher()
                    } catch {
                        return Fail(outputType: CarMakingStepInfo.self, failure: CarInfoRepositoryError.networkError(error))
                            .eraseToAnyPublisher()
                    }
                case .failure(let error):
                    return Fail(outputType: CarMakingStepInfo.self, failure: CarInfoRepositoryError.networkError(error))
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }

    func fetchPowertrain(model: String, type: String) -> AnyPublisher<CarMakingStepInfo, CarInfoRepositoryError> {
        fetchCarMakingStepInfo(for: CarInfoEndpoint.powertrain(model: model, type: type), step: .powertrain)
    }

    func fetchDrivingSystem() -> AnyPublisher<CarMakingStepInfo, CarInfoRepositoryError> {
        fetchCarMakingStepInfo(for: CarInfoEndpoint.drivingSystem, step: .driveMethod)
    }

    func fetchBodyType() -> AnyPublisher<CarMakingStepInfo, CarInfoRepositoryError> {
        fetchCarMakingStepInfo(for: CarInfoEndpoint.bodyType, step: .bodyType)
    }

    func fetchExteriorColor() -> AnyPublisher<CarMakingStepInfo, CarInfoRepositoryError> {
        fetchCarMakingStepInfo(for: CarInfoEndpoint.exteriorColor, step: .externalColor)
    }

    func fetchInteriorColor() -> AnyPublisher<CarMakingStepInfo, CarInfoRepositoryError> {
        fetchCarMakingStepInfo(for: CarInfoEndpoint.interiorColor, step: .internalColor)
    }

    func fetchWheel() -> AnyPublisher<CarMakingStepInfo, CarInfoRepositoryError> {
        fetchCarMakingStepInfo(for: CarInfoEndpoint.wheel, step: .wheelSelection)
    }

    func fetchAdditionalOption(category: String) -> AnyPublisher<CarMakingStepInfo, CarInfoRepositoryError> {
        fetchCarMakingStepInfo(for: CarInfoEndpoint.additionalOption(category: category), step: .optionSelection)
    }

    func fetchSingleExteriorColor(optionId: Int) -> AnyPublisher<CarMakingStepInfo, CarInfoRepositoryError> {
        fetchCarMakingStepInfo(for: CarInfoEndpoint.singleExteriorColor(optionId: optionId), step: .externalColor)
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
